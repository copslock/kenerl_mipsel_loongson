Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA19207; Thu, 26 Jun 1997 17:32:53 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA26599 for linux-list; Thu, 26 Jun 1997 17:32:38 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA26561 for <linux@engr.sgi.com>; Thu, 26 Jun 1997 17:32:32 -0700
Received: by heaven.newport.sgi.com (940816.SGI.8.6.9/940406.SGI)
	for linux@engr id RAA03068; Thu, 26 Jun 1997 17:32:30 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9706261732.ZM3066@heaven.newport.sgi.com>
Date: Thu, 26 Jun 1997 17:32:30 -0700
In-Reply-To: ariel@oz.engr.sgi.com (Ariel Faigon)
        "anon-ftp enabled on linus" (Jun 26, 11:46am)
References: <199706261846.LAA11570@oz.engr.sgi.com>
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: anon-ftp enabled on linus
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jun 26, 11:46am, Ariel Faigon wrote:
> Subject: anon-ftp enabled on linus
> FYI:
> 
> I just enabled public ftp access to linus.linux.sgi.com
> ftpd runs as user/group  ftp/ftp.
> 
> The chroot'ed location (~ftp) is /src (where the CVS tree resides)
> 
> I made sure that the source tree has no world write permissions
> or ftp group write permissions anywhere.
> 
> Since IRIX comes only with a dynamically liked '/bin/ls'
> I had to add /lib/rld libc.so and /dev/zero rooted at /src
> for dir to work.  I made all the permissions secure but
> another check would be appreciated.
> 
> If anyone feels like building the latest wu-ftpd (with all security
> patches) and replace the SGI ftpd - welcome.
> 
> A web site is planned too.  I hope we got a volunteer to set it up.
> 
> Let's keep the public areas only on the /src partition. I suggest
> /src/www (or some such) for the web doc root.
> 
> -- 
> Peace, Ariel
>-- End of excerpt from Ariel Faigon


BTW, I don't know if anybody cares but...

I have a defkeymap.map which generates all the escape sequences for
the IRIX keyboard.  IOW, it generates all the F1, F2,... escape
sequences to match what IRIX does.

It can be retrieved from
	http://reality.sgi.com/carlson_newport/files/defkeymap.map

Be sure to use the right mouse button and select "Save link as ..."
because Netscape tries to read it as an image file.

-- 

		Chris Carlson

	+------------------------------------------------------+
	| Also, carlson@sgi.com                                |
	|   Work:   (714) 224-4530                             |
	|   Vnet:       6-678-4530     FAX:    (714) 833-9503  |
	|                                                      |
	| Trivia fact: an electroencephalogram shows that a    |
	| human brain and a bowl of quivering lime Jell-O have |
	| the same waves.  [Time Magazine, Mar 17, 1997]       |
	+------------------------------------------------------+
