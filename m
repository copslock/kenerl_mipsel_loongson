Received:  by oss.sgi.com id <S554081AbRBAK3Z>;
	Thu, 1 Feb 2001 02:29:25 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:37646 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553953AbRBAK3N>; Thu, 1 Feb 2001 02:29:13 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14OGzE-0007lq-00; Thu, 01 Feb 2001 11:29:08 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14OGzD-0001js-00; Thu, 01 Feb 2001 11:29:07 +0100
Date:   Thu, 1 Feb 2001 11:29:07 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Erik Aderstedt <erik@ic.chalmers.se>
Cc:     linux-mips@oss.sgi.com
Subject: Re: OSLoadOptions
Message-ID: <20010201112907.A6581@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: Erik Aderstedt <erik@ic.chalmers.se>,
	linux-mips@oss.sgi.com
References: <004b01c08c33$e7b42ee0$a3291081@mc2.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004b01c08c33$e7b42ee0$a3291081@mc2.chalmers.se>; from erik@ic.chalmers.se on Thu, Feb 01, 2001 at 10:46:51AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 01, 2001 at 10:46:51AM +0100, Erik Aderstedt wrote:
[..snip..] 
> The problem is that the kernel seems to be passed the string
> 'OSLoadOptions=<my kernel boot options>', instead of just the
> boot options. At least that is what is indicated by the line
> 
> Kernel command line: OSLoadOptions=init=/sbin/simpleinit
> 
> during boot. At the end of this mail is a clunky patch that fixes this, but
> I'm not sure if this is the right way to go about it.
Could you do a "diff -u" - it makes things far easier to read.
Doesn't cmdline.c ignore OSLoadOptions along with the other prom
variables?  cmdline.c in 2.4.0pre9:

static char *ignored[] = {
       "ConsoleIn=",
        "ConsoleOut=",
        "SystemPartition=", 
        "OSLoader=",
        "OSLoadPartition=",
        "OSLoadFilename=",
        "OSLoadOptions="
};

One can easily remove OSLoadOptions from the above list, but then one has
to make sure it is still possible to override the OSLoadOptions with the
PROMS boot command(this makes parsing more complex I think).
 -- Guido
