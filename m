Received:  by oss.sgi.com id <S305157AbQAMX2q>;
	Thu, 13 Jan 2000 15:28:46 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:28241 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAMX20>;
	Thu, 13 Jan 2000 15:28:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA03411; Thu, 13 Jan 2000 15:25:29 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA86927
	for linux-list;
	Thu, 13 Jan 2000 15:19:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA14554;
	Thu, 13 Jan 2000 15:19:34 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id PAA00405;
	Thu, 13 Jan 2000 15:19:23 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14462.23930.613311.264388@liveoak.engr.sgi.com>
Date:   Thu, 13 Jan 2000 15:19:22 -0800 (PST)
To:     Vince Weaver <weave@eng.umd.edu>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: identifying sgi system type
In-Reply-To: <Pine.GSO.4.21.0001131258320.25401-100000@z.glue.umd.edu>
References: <Pine.GSO.4.21.0001121729110.15153-100000@z.glue.umd.edu>
	<Pine.GSO.4.21.0001131258320.25401-100000@z.glue.umd.edu>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Vince Weaver writes:
 > Hello again
 > 
 > I was trying to see if I could get this Indigo2 to display that it is an
 > Indigo2 under /proc/cpuinfo [instead of current behavior, which assumes
 > all SGI's are indy's].
 > 
 > I thought that maybe I could get the PROM to tell me this info, using code
 > like this
 > 
 >     #include <asm/sgialib.h>
 > 
 >     struct linux_sysid *mree;
 > 
 >     mree=prom_getsysid();
 >     printk("Vendor: %s     Prod: %s\n",mree->vend,mree->prod);
 > 
 > 
 > the vendor is returned as SGI, but the "prod" just returns the serial
 > number [which seems to be just the last few octets of the MAC address of
 > the ethernet card].  
 > 
 > Is it possible to figure out what system type it is from this info?  Is
 > there another way to find out sgi system type?  Or is this just not
 > possible?

      It is possible, but only with a database of serial numbers which
is not readily available.  The simple way is to have the kernel export
the value of the "sgi_guiness" variable somehow, presumably via /proc.
