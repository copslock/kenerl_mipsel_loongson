Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DK9xb12846
	for linux-mips-outgoing; Thu, 13 Sep 2001 13:09:59 -0700
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DK9te12841
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 13:09:55 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15hcnx-0001rN-00; Thu, 13 Sep 2001 15:09:46 -0500
Message-ID: <3BA1107B.B585E570@cotw.com>
Date: Thu, 13 Sep 2001 15:00:59 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: Corrupted symbols for MIPS debugging...
References: <3BA10C29.713DB745@cotw.com> <20010913130354.A29649@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> > (gdb) target remote /dev/ttyS1
> > Remote debugging using /dev/ttyS1
> > 0x80012828 in breakinst () at af_packet.c:1879
> > 1879            sock_unregister(PF_PACKET);
> > (gdb) bt
> > #0  0x80012828 in breakinst () at af_packet.c:1879
> > #1  0x8001a0d4 in sys_create_module (name_user=0x10001dc8 "cfi_probe",
> >     size=8176) at module.c:305
> 
> Please provide
> 
> (gdb) list breakinst
> (gdb) print breakinst
> 
(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
0x80012828 in breakinst () at af_packet.c:1879
1879            sock_unregister(PF_PACKET);
(gdb) list breakinst
1874
1875    static void __exit packet_exit(void)
1876    {
1877            remove_proc_entry("net/packet", 0);
1878            unregister_netdevice_notifier(&packet_netdev_notifier);
1879            sock_unregister(PF_PACKET);
1880            return;
1881    }
1882
1883    static int __init packet_init(void)
(gdb) print breakinst
$1 = {<text variable, no debug info>} 0x80012824 <breakinst>
(gdb) c
Continuing.



-- 
 Steven J. Hill - Embedded SW Engineer
