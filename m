Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IDeC323467
	for linux-mips-outgoing; Fri, 18 Jan 2002 05:40:12 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IDe6P23463
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 05:40:06 -0800
Message-Id: <200201181340.g0IDe6P23463@oss.sgi.com>
Received: (qmail 26869 invoked from network); 18 Jan 2002 12:34:49 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 18 Jan 2002 12:34:49 -0000
Date: Fri, 18 Jan 2002 20:37:7 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Fw: behavior of accessing undefined io ports
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,all
  We have trouble debugging a little fpga cpu. It seems that accesses
to non-existing ports differ from what IDT cpu shows.

  Is there any standards that specifys the behavior?

  We have below code segment to demonstrate this problem:
       /* this results in 60 for idtRC64474,0 for our cpu */
        prom_printf("before write *1ee=%x\n",inb(0x1ee));
        outb(0xa0,0x1ee);
       /* this print 0 for idt,a0 for our cpu */
        prom_printf("immediately after write:*1ee=%x\n",inb(0x1ee));

        prom_printf("\nLINUX starting...\n");

        prom_init_cmdline();

        prom_meminit();

        /* both print 0xa */
        prom_printf("long after first write:*1ee=%x\n",inb(0x1ee));
        outb(0xb0,0x1ee);
        /* idt print 0,ours b0 */ 
        prom_printf("imme. after second write:*1ee=%x\n",inb(0x1ee));
        inb(0x21);
        prom_printf("init done.\n");
        /* both a */
        prom_printf("long after second write:*1ee=%x\n",inb(0x1ee));

   This hit us when linux probing ide drives: it writes to 0x1ee etc ports that doesn't
exist there. Our cpu read back the exact value it writes to the port so it think the drive
is there and makes unnecessary probing. And some other weird problems too.

   I haven't notice a clear statement for behaviors under such condition. Would you please
help me out? 

   Thank you in advance.





Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
