Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2A57ZL17345
	for linux-mips-outgoing; Sat, 9 Mar 2002 21:07:35 -0800
Received: from portablue.intern.mind.be (NAT.office.mind.be [62.166.230.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2A57U917339
	for <linux-mips@oss.sgi.com>; Sat, 9 Mar 2002 21:07:30 -0800
Received: by portablue.intern.mind.be (Postfix, from userid 505)
	id 8C9ABB2CEB; Sun, 10 Mar 2002 05:07:22 +0100 (CET)
Date: Sun, 10 Mar 2002 05:07:20 +0100
To: linux-mips@oss.sgi.com, geert@linux-m68k.org, wim@sonycom.com,
   lionel@sonycom.com, thomasv@sonycom.com, Nico.DeRanter@sonycom.com,
   tea@sonycom.com, joel@sonycom.com, michiels@CoWare.com, gds@denayer.wenk.be,
   p2@mind.be
Subject: DDB-5074 patch
Message-ID: <20020310040720.GA4336@mind.be>
Mail-Followup-To: p2@mind.be, linux-mips@oss.sgi.com,
	geert@linux-m68k.org, wim@sonycom.com, lionel@sonycom.com,
	thomasv@sonycom.com, Nico.DeRanter@sonycom.com, tea@sonycom.com,
	joel@sonycom.com, michiels@CoWare.com, gds@denayer.wenk.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag: Get yourself a real email client. http://www.mutt.org/
From: p2@mind.be (Peter De Schrijver)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Attached you will find a patch against the latest CVS kernel from oss.sgi.com
to fix the support for the NEC DDB-5074 evaluation board. Onboard
ethernet works now, as well as ps/2 keyboard support. PS/2 mouse support
might work as well. I didn't try it yet. Matrox Millenium II framebuffer
also works now. I didn't try other graphics boards, but it seems most of
them need some magic to work which only the (IA32-only) firmware knows
of.

Changes since last version :

+ Changes ddb_sync into NOP. This at last makes the system stable under
  high IRQ load. 
+ Some tweaks to the IRQ handler
+ Changed PCI BAR0 to 0, so main memory resides at address 0 in PCI
  address space.

TODO :

Add support for the NILE 4 watchdog timer
Add MTD support
Test other PCI cards (eg. SCSI or IDE cards)
Find a way to use the NILE 4 UART

Have Fun,

Peter.
