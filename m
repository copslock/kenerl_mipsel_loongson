Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA15447
	for <pstadt@stud.fh-heilbronn.de>; Mon, 13 Sep 1999 15:29:03 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA09409; Mon, 13 Sep 1999 06:23:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA48858
	for linux-list;
	Mon, 13 Sep 1999 06:17:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA66452
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Sep 1999 06:17:03 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03258
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Sep 1999 06:17:01 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id IAA29081;
	Mon, 13 Sep 1999 08:16:33 -0500
Date: Mon, 13 Sep 1999 08:14:43 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Jens Oeser <oeser@darmstadt.gmd.de>
cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Booting linux from sgi indy.
In-Reply-To: <37DCA99A.721092F@darmstadt.gmd.de>
Message-ID: <Pine.LNX.3.96.990913080954.12201B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Mon, 13 Sep 1999, Jens Oeser wrote:
> How can i cause an indy to boot linux automatically, the bootloader
> seems to drop that root=/dev/... parameter.
> Is there a way to boot without having an irix running? The most unusual
> way would be to build a 20mb efs partition for some kernels and mount it
> at another sgi, to copy over new kernels, but that won't be the
> solutions i'm looking for.

I have managed to get my Indigo2s to boot by themselves (actually with the
help of a bootp/tftp server).  I modified init/main.c like so:

static struct kernel_param raw_params[] __initdata = {
+       { "OSLoadOptions=", root_dev_setup },
        { "root=", root_dev_setup },

Then, at the boot prom prompt, I typed:

setenv -p OSLoadOptions /dev/sda1

This string is passed by bootp into the loaded kernel and everything boots
up without any user intervention.

Personally, I would like to have a better way to do this, but this works
for me, and I haven't found any drawbacks except needing to add on line to
kernel code.

-Andrew
