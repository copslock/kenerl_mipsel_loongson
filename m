Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32LuYW08308
	for linux-mips-outgoing; Mon, 2 Apr 2001 14:56:34 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32LuUM08299;
	Mon, 2 Apr 2001 14:56:30 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id XAA57476;
	Mon, 2 Apr 2001 23:56:21 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.12 #1 (Debian))
	id 14kCJ9-0004Ww-00; Mon, 02 Apr 2001 23:56:19 +0200
Date: Mon, 2 Apr 2001 23:56:19 +0200
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010402235619.C5099@rembrandt.csv.ica.uni-stuttgart.de>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses>; from kevink@mips.com on Mon, Apr 02, 2001 at 09:20:44PM +0200
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:
[snip]
>> Which looks like you don't have a glibc package installed.
>
>That's correct.  Because I have the strong suspicion that
>RH 7.0 PC rpm is too stupid to put it somewhere useful, and
>is far more likely to clobber my native i686 libc unless I give
>it the correct incantations.   Hence my question.  And
>of course, if it ends up somewhere other than /usr/lib,
>presumably I need to tweak mips-linux-gcc to know
>where it is.  I'm sure that's documented somewhere,
>too, but it would save me several hours if someone had
>a description of how to install the full cross environment
>on a Linux PC.

There's even a script by Keith Weselowski to do that, see e.g.
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/ 

[snip]
>There is no visible link to it on the oss.sgi.com/mips page - then again
>there's no visible link to oss.sgi.com/mips from the oss.sgi.com page,
>so at least things are consistent.  ;-)  It used to be accessible from the
>FAQ that used to be at oss.sgi.com/mips/faq.html, but that document
>has be deleted, leaving no forwarding address.  The pointers on Brad
>LaRonde's site is even older (remember linux.sgi.com?).

http://www.linux-mips.org/ has a good link page (if it isn't down).


Thiemo
