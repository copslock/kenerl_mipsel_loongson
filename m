Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2004 01:42:44 +0000 (GMT)
Received: from mx2.idealab.com ([IPv6:::ffff:64.208.8.4]:58373 "EHLO
	dirk.pas.idealab.com") by linux-mips.org with ESMTP
	id <S8225370AbUBTBmo>; Fri, 20 Feb 2004 01:42:44 +0000
Received: (qmail 15048 invoked by uid 85); 20 Feb 2004 01:42:30 -0000
Received: from baitisj@evolution.com by dirk.idealab.com with qmail-scanner-1.01 (sweep: 2.6/3.49. . Clean. Processed in 2.682525 secs); 20 Feb 2004 01:42:30 -0000
X-Qmail-Scanner-Mail-From: baitisj@evolution.com via dirk.idealab.com
X-Qmail-Scanner: 1.01 (Clean. Processed in 2.682525 secs)
Received: from unknown (HELO powerpuff.evo1.pas.lab) (10.1.22.10)
  by 0 with SMTP; 20 Feb 2004 01:42:28 -0000
Subject: Re: IT8172 IDE support in 2.4.24
From: Jeffrey Baitis <baitisj@evolution.com>
Reply-To: baitisj@evolution.com
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F25901D0A6AB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
References: <9DFF23E1E33391449FDC324526D1F25901D0A6AB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Organization: 
Message-Id: <1077241347.4164.16.camel@powerpuff.evo1.pas.lab>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Feb 2004 17:42:28 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <baitisj@evolution.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi Adam:

Here's a more generic test. can you try

        for i in a b c d ; do
          echo "Trying hd$i";
          dd if=/dev/hd$i count=1 of=/dev/null;
        done

Not sure offhand if the ITE 8172 has multiple IDE channels/headers; your
HDD may also have an unreadable partition table.

Good luck
-Jeff

On Thu, 2004-02-19 at 10:17, Adam Kiepul wrote:
> Hi,
> 
> Could anyone please tell me whether the 2.4.24 source actually supports the IDE HDD in the default configuration for the ITE 8172?
> I have built the kernel and it boots up fine with the NFS root. However, it is unable to mount the root file system on a HDD. When I try to mount the /dev/hda1 while running with NFS root I get the "/dev/hda1 is not a valid block device" message. Am I missing something?
> 
> Thanks a lot,
> 
> -------------------
> Adam Kiepul
> Sr. Applications Engineer
> 
> PMC-Sierra, Microprocessor Division
> Mission Towers One
> 3975 Freedom Circle
> Santa Clara, CA 95054, USA
> Direct: 408 239 8124
> Fax: 408 492 9462
> http://www.pmc-sierra.com/processors
-- 
Jeffrey Baitis <baitisj@evolution.com>
