Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f67IwZh03362
	for linux-mips-outgoing; Sat, 7 Jul 2001 11:58:35 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f67IwXV03358
	for <linux-mips@oss.sgi.com>; Sat, 7 Jul 2001 11:58:34 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 9370F3E90; Sat,  7 Jul 2001 11:51:32 -0700 (PDT)
Date: Sat, 7 Jul 2001 11:51:32 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Documentation on MIPS kernel options...
Message-ID: <20010707115132.A452@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B473ABF.F2444CEE@cotw.com>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 07, 2001 at 11:37:19AM -0500, Steven J. Hill wrote:

> CONFIG_ARC_CONSOLE

This arguably belongs to the Kernel Hacking section (or its CML2
equivalent).  It isn't useful (and in fact will be highly frustrating)
for anyone else.

---cut here---

The ARC console is a low-level console device using the ARC firmware
for output.  This is useful for debugging, especially if there is no
driver for the serial ports.  You cannot use the ARC console as a
general serial device.  Unless you have a specific requirement for
this functionality, you should not select this option.

---cut here---

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
 	"There is no such song as 'Acid Acid Acid' by 'The Acid Heads'
	 but there might as well be." --jwz
