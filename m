Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HKkWb31777
	for linux-mips-outgoing; Tue, 17 Jul 2001 13:46:32 -0700
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HKkVV31774
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 13:46:31 -0700
Received: (qmail 6374 invoked from network); 17 Jul 2001 20:46:25 -0000
Received: from r049112.stusta.swh.mhn.de (HELO magi) (10.150.49.112)
  by mailhub.stusta.mhn.de with SMTP; 17 Jul 2001 20:46:25 -0000
Received: from oliver by magi with local (Exim 3.22 #1 (Debian))
	id 15MbjY-00015t-00
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 22:46:20 +0200
Date: Tue, 17 Jul 2001 22:46:17 +0200
From: "Oliver M . Bolzer" <oliver@gol.com>
To: linux-mips@oss.sgi.com
Subject: Re: MIPS processor identification register
Message-ID: <20010717224617.A4132@magi.sukisuki.org>
References: <1114092660.995374763@[192.168.1.117]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Mutt/1.2.4i-jp0
In-Reply-To: <1114092660.995374763@[192.168.1.117]>; from naren@clearwaternetworks.com on Tue, Jul 17, 2001 at 12:59:23PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

On Tue, Jul 17, 2001 at 12:59:23PM -0700, Narendra Sankar <naren@clearwaternetworks.com> wrote...
 
> Is there a complete list somewhere of the different PRID (CP0 register 15) 
> values across the entire MIPS family - including all the different vendors?

Not that I know of any, but for reference, the PlayStation2's EmotionEngine
Processor (R5900) has a fixed Impl value of 0x2E.

[oliver@asuka tmp]$ cat /proc/cpuinfo 
cpu                     : MIPS
cpu model               : R5900 V1.4
system type             : EE PS2
BogoMIPS                : 392.40
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : yes
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available


# If anybody is interested in poking around a PlayStation2 running Linux
# by SSH. send me a mail. I got a non-NDA fully GPL/LGPL compliant unit.
# It's running an 2.2.1 kernel that looks more like a 2.2.1{8,9} when
# looked under the hood. It was delivered that way by SCEI and somebody
# despeartely needs to update it. Unfortunatly I'm a userspace guy.
  
-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
