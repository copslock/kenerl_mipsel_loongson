Received:  by oss.sgi.com id <S305160AbQARDHK>;
	Mon, 17 Jan 2000 19:07:10 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:4933 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305159AbQARDGx>;
	Mon, 17 Jan 2000 19:06:53 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA05747; Mon, 17 Jan 2000 19:08:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA33625
	for linux-list;
	Mon, 17 Jan 2000 18:49:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA98631
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 18:49:33 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07682
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 18:49:31 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id UAA21137;
	Mon, 17 Jan 2000 20:49:20 -0600
Date:   Mon, 17 Jan 2000 20:47:38 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Jeff Harrell <jharrell@ti.com>,
        Conrad Parker <conradp@cse.unsw.edu.au>,
        linux@cthulhu.engr.sgi.com
Subject: Re: question concerning serial console setup
In-Reply-To: <20000118031419.B10759@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.1000117203947.28191C-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Tue, 18 Jan 2000, Ralf Baechle wrote:
> On Mon, Jan 17, 2000 at 07:56:42PM -0600, Andrew R. Baker wrote:
> > > A simple solution is to hardwire the commmand line in
> > > arch/mips/kernel/setup.c.
> > 
> > I have some hackish code that queries the prom enviroment and edits the
> > commandline to reflect the appropriate console.  If that is worthwhile to
> > have available I will dig up a diff.
> 
> Have you considered hacking kerne/printk.c:console_setup() instead?
> There is already some SPARC code there.

The code in kernel/printk.c seems to be only involved in normalizing the
names of the serial ports.  What I needed was to get the console
enviroment setting from the prom.  I don't like the idea of putting prom
code into kernel/printk.c.  Here is the code I used (from
arch/mips/arc/cmdline.c):

        /* get the console enviroment variable into the command line.
         * But only if the console parameter wasn't entered by the user.
         * Is this a bad thing to do here?
         * -Andrew
         */
        if(console_option == 0) 
        {
                console = prom_getenv("console");
                strcpy(cp, "console=");
                cp += strlen("console=");
                strcpy(cp, console);
                cp += strlen(console);
                *cp++ = ' ';
        }


I don't like the way it messes with the passed commandline.  However, we
could read the value into some other variable and let kernel/printk.c pick
it up from there.  

-Andrew  
