Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA312045; Fri, 11 Jul 1997 11:04:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA04384 for linux-list; Fri, 11 Jul 1997 11:03:50 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA04322 for <linux@engr.sgi.com>; Fri, 11 Jul 1997 11:03:40 -0700
Received: by heaven.newport.sgi.com (940816.SGI.8.6.9/940406.SGI)
	for linux@engr id LAA08601; Fri, 11 Jul 1997 11:02:58 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9707111102.ZM8599@heaven.newport.sgi.com>
Date: Fri, 11 Jul 1997 11:02:58 -0700
In-Reply-To: ariel@oz.engr.sgi.com (Ariel Faigon)
        "Re: How to get the masses (IRIX<->Linux) (fwd)" (Jul 10,  3:02pm)
References: <199707102202.PAA24075@oz.engr.sgi.com>
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: How to get the masses (IRIX<->Linux) (fwd)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jul 10,  3:02pm, Ariel Faigon wrote:
> Subject: Re: How to get the masses (IRIX<->Linux) (fwd)
> [I'm forwarding this very helpful hint from Christian to the list
>  not sure if all our audience, especially those outside SGI are aware
>  of all these options.]
>
> Now since after setting nvram it'll always boot Linux ;-)
> the question is how to toggle two different (Linux/IRIX)
> nvram settings in a friendly trivial way...
>
> Looks like a SILO option after the wakup/reboot would be the best.
>
> 	Press 1 to boot IRIX [default]
> 	Press 2 to boot Linux
>
>-- End of excerpt from Ariel Faigon


Actually, we frequently have two versions of IRIX that we need to
boot each from a different disk drive.  We have a shell script which
root can run which sets up nvram so that the next time we reboot, it
will come up in the other OS.  Here's the script below:


#!/bin/sh
#
# Usage: switch_os 6.2 switches to 6.2
#        switch_os 6.5 switches to 6.5

if [ $# -lt 1 ] ; then
  echo "Usage: switch_os <6.2|6.5>"
  exit
fi
if [ $1 != "6.2" -a $1 != "6.5" ] ; then
  echo "Usage: switch_os <6.2|6.5>"
  exit
fi
if [ $1 = "6.2" ] ; then
  sys_part="scsi(0)disk(1)rdisk(0)partition(8)"
  os_load="scsi(0)disk(1)rdisk(0)partition(0)"
else
  sys_part="scsi(0)disk(3)rdisk(0)partition(8)"
  os_load="scsi(0)disk(3)rdisk(0)partition(0)"
fi
echo "rebooting venus to use $1 in 5 seconds..."
sleep 5
/sbin/nvram SystemPartition $sys_part
/sbin/nvram OSLoadPartition $os_load
/etc/reboot

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
