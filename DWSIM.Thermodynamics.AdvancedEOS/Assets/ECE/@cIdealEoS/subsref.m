function varargout = subsref(this, index)
%Accesor for cIdealEoS class

%Copyright (c) 2011 �ngel Mart�n, University of Valladolid (Spain)
%This program is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%You should have received a copy of the GNU General Public License
%along with this program.  If not, see <http://www.gnu.org/licenses/>.

switch index(1).type
    
    case '.'
        switch index(1).subs
            case 'ID'
                if isempty (this)
                    varargout = {};
                else
                    varargout = {this.mID};
                end
            otherwise
                error(['Reference to non-existent field ' index(1).subs '.']);
        end
        
    case '()'
        this_subset = this(index(1).subs{:});

        if length(index) == 1
            varargout = {this_subset};
        else
            varargout = cell(size(this_subset));
            [varargout{:}] = subsref(this_subset, index(2:end));
        end
        
    otherwise
        error (['Unexpected index.type of ' index(1).type]);          
end