Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 22:45:29 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:35228 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S8133901AbWGZVpU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 22:45:20 +0100
Received: from [192.168.1.115] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id C40D9E4051
	for <linux-mips@linux-mips.org>; Wed, 26 Jul 2006 15:00:04 -0700 (PDT)
Subject: Boot args on YAMON and Console init on the Encore M3.
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 26 Jul 2006 14:50:17 -0700
Message-Id: <1153950618.6491.26.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Background Info: working on porting linux kernel 2.6 to the DB1500 and
Encore M3 board both of which are run on the AU1500 processor.

Hi,

Thanks Pete for your inputs.  I changed the DB1500 board setting so that
it is now Big Endian.

Now when I load the image and issue the 'go' command in YAMON, I dont
see anything happen.  I cant stop the process by a control C.  Where is
the logbuf located where all the commands are dumped?

I m also pasting here the output of the setenv command which shows me
the environment variables and what they are set to.  What are the
bootargs meant to be set to?

MAC         (R/W)  0
bootargs0   (USER) ip=xxx.xxx.x.150::::db1500:eth0:off
bootargs1   (USER) nfsroot=xxx.xxx.x.15:/usr/local/targets/mips-target
bootargs2   (USER) root=ff noinitrd video=atyfb:1024x768-8@70
bootfile    (R/W)  vmlinux.srec
bootprot    (R/W)  tftp
bootserport (R/W)  tty0
bootserver  (R/W)  xxx.xxx.x.8
ethaddr     (R/W)  xx.xx.xx.xx.xx.xx
gateway     (R/W)  xxx.xxx.xx.1
ipaddr      (R/W)  xxx.xxx.x.146
memsize     (RO)   0x04000000
modetty0    (RO)   115200,n,8,1,none
modetty1    (RO)   115200,n,8,1,none
prompt      (R/W)  YAMON
start       (R/W)  load; go
subnetmask  (R/W)  255.255.255.0

I have another query about a different board - the Alchemy Encore M3
which has the same processor, AU1500, as the DB1500 above.

The ENM3 has a VIA Southbridge on the PCI bus.  The serial port on the
Southbridge is connected to the board.  Now I want to 'see' what is
happening during the boot process, thus, want to see messages being
output, through the serial port.  A UART driver is thus no good.

It has been suggested that I write a TLB entry during the initial
booting process (eg. when the memory is mapped, timer interrupt is set
up etc.) to route all the printk outputs to the serial port (which will
be 'hardcoded').  However, I am really not sure how to do this!  I m
confused about this:
- if this entry is written, what should point to the address in
question? 
- should it just be one address or a chunk of addresses so that longer
messages maybe printed?  If this question doesnt make sense, then I
think I m unclear on the actual process of what actually happens when
the kernel comes into the picture.  Are there any links that will help
clarify the matter? I have already looked at 
http://www.linux-mips.org/wiki/Porting  and
http://linux.junsun.net/porting-howto/

I am reading the following books:

1) Understanding the Linux Kernel - for 2.4 kernel
2) Linux Device Drivers: again for the 2.4 kernel
3) Linux Kernel Development (kernel 2.6)

Please shed some light on this cus I think I m just trying to make
guesses in the dark!

I really appreciate all the help I have gotten so far and thanks in
advance for your replies.

Regards,
Ashlesha.
