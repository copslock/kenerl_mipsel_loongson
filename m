Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Dec 2002 09:25:18 +0000 (GMT)
Received: from krt.neobee.net ([IPv6:::ffff:217.26.72.90]:20491 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8225233AbSLYJZR>;
	Wed, 25 Dec 2002 09:25:17 +0000
Received: (from root@localhost)
	by krt.neobee.net (8.11.6/8.11.4) id gBPA18320261
	for linux-mips@linux-mips.org; Wed, 25 Dec 2002 11:01:08 +0100
Received: from stanojevic ([192.168.0.224])
	by krt.neobee.net (8.11.6/8.11.4) with SMTP id gBPA0wd20233
	for <linux-mips@linux-mips.org>; Wed, 25 Dec 2002 11:01:08 +0100
Message-ID: <000b01c2abf7$5d705570$e000a8c0@micronasnit.com>
From: "Nemanja Popov" <Nemanja.Popov@micronasnit.com>
To: <linux-mips@linux-mips.org>
Subject: linux port for Lexra 4280 based System On Chip (MDE9500)
Date: Wed, 25 Dec 2002 10:23:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-scanner: scanned by Inflex 1.0.8 - (http://pldaniels.com/inflex/)
Return-Path: <Nemanja.Popov@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nemanja.Popov@micronasnit.com
Precedence: bulk
X-list: linux-mips

I'm trying to port linux on digital TV decoder chip MDE9500 which is based
on Lexra 4280. I've been studied linux port for Lexra processors and board
PB20K. I've found there configuration for MMU precisely TLB and its size.
There is function probe_tlb() in
cvs.sourceforge.net/cgi-bin/viewcvs.cgi/linux-mips/linux/arch/mips/mm/c-lexr
a.c which determines tlbsize.

 static void __init probe_tlb(void)
 {
 int i;
 unsigned long temp;

 mips_cpu.tlbsize = 8;         //     <<<<<<<<<<<

 temp = get_entryhi();

 for (i=63; i>0; i=i-8) {
  set_index(i<<8);
  set_entryhi(0xaaaaaa80);
  tlb_write_indexed();
  tlb_read();
  if (get_entryhi() == 0xaaaaaa80)
  {
      mips_cpu.tlbsize = (i + 1);
      break;
  }
 };
 set_entryhi(temp);
 printk("%d entry TLB.\n", mips_cpu.tlbsize);
}

  I've tried that function on my system and result was mips_cpu.tlbsize = 8,
BUT that value was set in the above marked line of code, not in the for
loop. Is that right value ???
My oppinion is that the tlbsize = 0. Correct me please :)

  From documentation for Lexra 4280 I haven't found anything that points to
TLB and stuff about MMU. Has anyone tried probe_tlb() on LX4280, and if so
what is the result.

NOTE: MDE9500 is embeded system and Lexra LX4280 in it probably has less
features than as a single chip (processor). I don't have any documenatation
about  that, so I don't know if my assumtion is true.

  If  tlbsize = 0 does that mean that there is no MMU and I'll be forced to
use uClinux and its support for processors whithout MMU  :(

Thanks in advance.

Regards,
Nemanja Popov
