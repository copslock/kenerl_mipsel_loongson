Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 16:13:58 +0000 (GMT)
Received: from ppp-104.net10.magic.fr ([IPv6:::ffff:195.154.128.104]:63238
	"HELO volvic.sud.stepmind.com") by linux-mips.org with SMTP
	id <S8225223AbTCMQN5>; Thu, 13 Mar 2003 16:13:57 +0000
Received: (qmail 27150 invoked from network); 13 Mar 2003 16:03:51 -0000
Received: from eku.sud.stepmind.com (HELO stepmind.com) (192.168.1.103)
  by volvic.sud.stepmind.com with SMTP; 13 Mar 2003 16:03:51 -0000
Message-ID: <3E70ACE0.5010306@stepmind.com>
Date: Thu, 13 Mar 2003 17:08:00 +0100
From: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@stepmind.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030302
X-Accept-Language: fr, en, de
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: PROM variables
References: <3E7057A6.60007@stepmind.com> <20030313102601.GD24866@bogon.ms20.nix>
In-Reply-To: <20030313102601.GD24866@bogon.ms20.nix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <vincent.stehle@stepmind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vincent.stehle@stepmind.com
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
[..]
> When doing this I'd write into the NVRAM
> directly instead of using the Arcs functions, I think the necessary info
> is in the IRIX headers.

I had a look at the ARC spec. (ARC/riscspec.pdf), and I am affraid the 
only (documented) way to access PROM env. variables are the two get/set 
functions.

In that case, the /proc approach makes sense IMHO.

Looking at hpc3 spec. and ip22-sc.c, I understand that PROM data are 
stored in the EEPROM behind the hpc3.

Maybe a reasonable approach is:

o write a new char device driver (as pc's /dev/nvram for example)
o move eeprom read/write routines from ip22-sc.c somewhere else,
   and use those routines both in ip22-sc.c and the char driver
o guess the format/offsets of the info. stored in nvram
o then write some user space app. to do the env. variable
   specific part.

In that latter case, the /proc approach makes less sense IMHO.

What do you think ? Am I missing some documentation ? Is there more in 
the IRIX headers ? (can't check right now, but I have them at home)

Regards,

--
  Vincent Stehlé
