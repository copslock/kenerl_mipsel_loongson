Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAT7EKc24831
	for linux-mips-outgoing; Wed, 28 Nov 2001 23:14:20 -0800
Received: from surfers.oz.agile.tv (fw.oz.agile.tv [210.9.52.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAT7EHo24827
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 23:14:17 -0800
Received: from burleighw98 (burleigh-w98.oz.agile.tv [192.168.16.130])
	by surfers.oz.agile.tv (8.11.2/8.11.2) with SMTP id fAT6EAv24772
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 16:14:10 +1000
Message-ID: <01f201c1789d$0f872c00$8061a8c0@oz.agile.tv>
From: "Jim Grohn" <Jim.Grohn@Agile.TV>
To: <linux-mips@oss.sgi.com>
Subject: crash from unalgined bad address passed to a syscall 
Date: Thu, 29 Nov 2001 16:14:10 +1000
Organization: AgileTV
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I get a crash when I run the latest LTP.  The test passes 0x1 to getpeername
for namelen (socklen_t*)

I think the problem may be in emulate_load_store_insn.   Should the code
below be passing "pc" to search_exception_table and fixup_exception?
regs->cp0_epc has been adjusted by compute_return_epc (called from do_ade)
to be 4 bytes past the instruction that caused the problems.

*************************
fault:
 /* Did we have an exception handler installed? */
 fixup = search_exception_table(regs->cp0_epc);
 if (fixup) {
  long new_epc;
  new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
  printk(KERN_DEBUG "%s: Forwarding exception at [<%lx>] (%lx)\n",
         current->comm, regs->cp0_epc, new_epc);
  regs->cp0_epc = new_epc;
  return;
 }
