Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA15497 for <linux-archive@neteng.engr.sgi.com>; Fri, 11 Sep 1998 11:14:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA03554
	for linux-list;
	Fri, 11 Sep 1998 11:13:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from jibe.engr.sgi.com (jibe.engr.sgi.com [150.166.37.45])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA72330;
	Fri, 11 Sep 1998 11:13:22 -0700 (PDT)
	mail_from (kyriazis@jibe.engr.sgi.com)
Received: (from kyriazis@localhost) by jibe.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) id LAA01299; Fri, 11 Sep 1998 11:13:21 -0700 (PDT)
From: kyriazis@jibe.engr.sgi.com (George Kyriazis)
Message-Id: <199809111813.LAA01299@jibe.engr.sgi.com>
Subject: Re: newport questions...
In-Reply-To: <Pine.LNX.3.96.980911135113.372B-100000@lager.engsoc.carleton.ca> from Alex deVries at "Sep 11, 98 01:56:16 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 11 Sep 1998 11:13:21 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> - What is a span, and how does it differ from a line?
> 
A span is a horizontal row of pixels.  The idea is that you specify only
one Y, and two X's.  

Sometimes you don't specify a second X, but iterate writing 32-bit
dither patterns till you are done.  Note that you can do the same thing
with lines, but you have to specify all of x0,y0,x1,y1.

> - is the usable area *really* 5439x5120 pixels?  this strikes me as
> incredibly fine ( from page 26)
> 
No.  The address of the last pixel that corresponds to memory is that
(more or less).  Top left is 4096,4096.  Add 1280,1024 to it you get:
5376,5120.  Add 85 pixels of extra memory to the right of 5376 and you
get 5461.  So the last addressable pixel is 5460,5120 (my version of
the doc has 5460 not 5439).

The usable screen is really only between 4096,4096 and 5376,5120.

> - can someone give me a moron's guide to what an iterator is?
> 
You start from x0,y0.  Eventually you have to get to x1,y1.  The iterators
add a dx,dy to each x,y (starting from x0,y0) that eventually gets you to 
x1,y1.  Each clock tick of the iterator produces a new x,y and therefore a
new pixel.

If you have more REX3 specific questions, feel free to contact me directly
so we don't clog the group.

  --george
-- 
-----------------------------------------------------------------------------
George Kyriazis  | Silicon Graphics, Inc., 8U-590 |  kyriazis@sgi.com
     KF6QKG      | 2011 N. Shoreline Blvd.        |  650-933-2828
                 | Mt. View, CA 94043             | 
