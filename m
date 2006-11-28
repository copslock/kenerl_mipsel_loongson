Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2006 07:11:08 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.173]:60853 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038715AbWK1HLE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Nov 2006 07:11:04 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1490365uga
        for <linux-mips@linux-mips.org>; Mon, 27 Nov 2006 23:10:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=CBD/wnY00vJ8iDKf+Zuxh2oC2e1vkjreK6NYbSKX7kGHnrhERVhUHoBSh5RlHGhzOtATKkRvJJVGVTTGpwhjoXWIITSRVFOHwFgiQCUmCZ/uk1DMvIGXlcGmLx/SKcLvmscTIRh99fjNfBQZqfdQdj0rHkaUrbB9yeO5nLFH1IQ=
Received: by 10.78.149.15 with SMTP id w15mr624143hud.1164697850709;
        Mon, 27 Nov 2006 23:10:50 -0800 (PST)
Received: by 10.78.141.4 with HTTP; Mon, 27 Nov 2006 23:10:50 -0800 (PST)
Message-ID: <69a573da0611272310y6a1b79adx5876c28dc756fabb@mail.gmail.com>
Date:	Tue, 28 Nov 2006 12:40:50 +0530
From:	"chandrashekar mogilicherla" <chandu.nitw@gmail.com>
To:	linux-mips@linux-mips.org, Puneet <puneet.goel@samsung.com>
Subject: USB keyboard not getting handled???????
In-Reply-To: <69a573da0611272302h78e87f10w7d1bbb3037946172@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3741_24166097.1164697850680"
References: <69a573da0611272302h78e87f10w7d1bbb3037946172@mail.gmail.com>
Return-Path: <chandu.nitw@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chandu.nitw@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_3741_24166097.1164697850680
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Iam using a device with linux 2.6.11 kernel running on mips arch.
I have got a problem trying to enable usb keyboard  on my device.
When i enable following options in kernel config
         USB_CONFIG
           ohci, ehci
          hid or boot hid
          keyboard in input devices

USB keyboard is detected . It is shown in /proc/bus/usb/devices , drivers
are loaded. But keyboard is not working.

Following is the mesg log i get when i enabled usb feaures in kernel,
------------------------------------------------------------------------------------------------
In ehci_hcd_au1xxx_drv_probe
drivers/usb/host/ehci-au1xxx.c: starting Au1xxx EHCI USB Controller
drivers/usb/host/ehci-au1xxx.c: Clock to USB host has been enabled
au1xxx-ehci au1xxx-ehci0: reset hcs_params 0x1212 dbg=0 cc=1 pcc=2 ordered
ports=2
au1xxx-ehci au1xxx-ehci0: reset hcc_params 0012 thresh 1 uframes
256/512/1024
ehci_hcd (Au1xxx) at 0xb4020200, irq 29
au1xxx-ehci au1xxx-ehci0: new USB bus registered, assigned bus number 1
au1xxx-ehci au1xxx-ehci0: reset command 080002 (park)=0 ithresh=8
period=1024 Reset HALT
au1xxx-ehci au1xxx-ehci0: init command 010009 (park)=0 ithresh=1 period=256
RUN
au1xxx-ehci au1xxx-ehci0: USB 0.0 initialized, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Au1xxx EHCI
usb usb1: Manufacturer: Linux 2.6.11 ehci_hcd
usb usb1: SerialNumber: au1xxx
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (Au1xxx)
block sizes: ed 64 td 64
hub 1-0:1.0: state 5 ports 2 chg 0006 evt 0007
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 001403 POWER sig=k  CSC
CONNECT
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
In ohci_hcd_au1xxx_drv_probe
drivers/usb/host/ohci-au1xxx.c: starting Au1xxx OHCI USB Controller
drivers/usb/host/ohci-au1xxx.c: Clock to USB host has been enabled
ohci_hcd (Au1xxx) at 0xb4020100, irq 29
au1xxx-ohci au1xxx-ohci0: new USB bus registered, assigned bus number 2
au1xxx-ohci au1xxx-ohci0: ohci_au1xxx_start, ohci:86e9fcf0
au1xxx-ohci au1xxx-ohci0: resetting from state 'reset', control = 0x0
au1xxx-ohci au1xxx-ohci0: OHCI controller state
au1xxx-ohci au1xxx-ohci0: OHCI 1.0, with legacy support registers
au1xxx-ohci au1xxx-ohci0: control 0x083 HCFS=operational CBSR=3
au1xxx-ohci au1xxx-ohci0: cmdstatus 0x00000 SOC=0
au1xxx-ohci au1xxx-ohci0: intrstatus 0x00000044 RHSC SF
au1xxx-ohci au1xxx-ohci0: intrenable 0x8000001a MIE UE RD WDH
au1xxx-ohci au1xxx-ohci0: hcca frame #0021
au1xxx-ohci au1xxx-ohci0: roothub.a 10000202 POTPGT=16 NPS NDP=2
au1xxx-ohci au1xxx-ohci0: roothub.b 00000000 PPCM=0000 DR=0000
au1xxx-ohci au1xxx-ohci0: roothub.status 00008000 DRWE
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [0] 0x00000100 PPS
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [1] 0x00000100 PPS
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Au1xxx OHCI
usb usb2: Manufacturer: Linux 2.6.11 ohci_hcd
usb usb2: SerialNumber: au1xxx
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 32ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
au1xxx-ehci au1xxx-ehci0: port 1 low speed --> companion
au1xxx-ohci au1xxx-ohci0: created debug files
Initializing USB Mass Storage driver...
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 003002 POWER OWNER
sig=se0  CSC
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: state 5 ports 2 chg 0006 evt 0007
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] = 0x00010301 CSC
LSDA PPS CCS
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC
LSDA PPS PES CCS
usb 2-1: new low speed USB device using au1xxx-ohci and address 2
ghzhang: USB inserted
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC
LSDA PPS PES CCS
usb 2-1: skipped 1 descriptor after interface
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: default language 0x0409
usb 2-1: Product: HP Basic USB Keyboard
usb 2-1: Manufacturer: CHICONY
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0002
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [CHICONY HP Basic USB Keyboard] on
usb-au1xxx-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2(2004/08/27)
usbcore: registered new driver rtl8150
usbcore: registered new driver usblcd
drivers/usb/misc/usblcd.c: USBLCD Driver Version 1.04 (C) Adams IT Services
http://www.usblcd.de
drivers/usb/misc/usblcd.c: USBLCD support registered.
usbcore: registered new driver usbled
usbcore: registered new driver usbtest

-----------------------------------------------------------------------------------------------------
cat /proc/bus/input/devices

I: Bus=0003 Vendor=03f0 Product=0024 Version=0300
N: Name="CHICONY HP Basic USB Keyboard"
P: Phys=usb-au1xxx-1/input0
H: Handlers=event0
B: EV=120013
B: KEY=10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7
----------------------------------------------------------------------------

CAN ANYBODY HELP ME IN THIS REGARD,

Is there anything to do with "keybdev" and "/sbin/hotplug"?????

Both of these are not present on my system

Thanking you in advance,
M.Chandrashekar

------=_Part_3741_24166097.1164697850680
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><span class="gmail_quote"></span>Iam using a device with linux 2.6.11 kernel running on mips arch.<br>I have got a problem trying to enable usb keyboard&nbsp; on my device.<br>
When i enable following options in kernel config<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB_CONFIG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ohci, ehci<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hid or boot hid<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keyboard in input devices<br>
<br>
USB keyboard is detected . It is shown in /proc/bus/usb/devices , drivers are loaded. But keyboard is not working. <br>
<br>
Following is the mesg log i get when i enabled usb feaures in kernel,<br>
------------------------------------------------------------------------------------------------<br>
In ehci_hcd_au1xxx_drv_probe<br>
drivers/usb/host/ehci-au1xxx.c: starting Au1xxx EHCI USB Controller<br>
drivers/usb/host/ehci-au1xxx.c: Clock to USB host has been enabled<br>
au1xxx-ehci au1xxx-ehci0: reset hcs_params 0x1212 dbg=0 cc=1 pcc=2 ordered ports=2<br>
au1xxx-ehci au1xxx-ehci0: reset hcc_params 0012 thresh 1 uframes 256/512/1024<br>
ehci_hcd (Au1xxx) at 0xb4020200, irq 29<br>
au1xxx-ehci au1xxx-ehci0: new USB bus registered, assigned bus number 1<br>
au1xxx-ehci au1xxx-ehci0: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT<br>
au1xxx-ehci au1xxx-ehci0: init command 010009 (park)=0 ithresh=1 period=256 RUN<br>
au1xxx-ehci au1xxx-ehci0: USB 0.0 initialized, EHCI 1.00, driver 10 Dec 2004<br>
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1<br>
usb usb1: default language 0x0409<br>
usb usb1: Product: Au1xxx EHCI<br>
usb usb1: Manufacturer: Linux 2.6.11 ehci_hcd<br>
usb usb1: SerialNumber: au1xxx<br>
usb usb1: hotplug<br>
usb usb1: adding 1-0:1.0 (config #1, interface 0)<br>
usb 1-0:1.0: hotplug<br>
hub 1-0:1.0: usb_probe_interface<br>
hub 1-0:1.0: usb_probe_interface - got id<br>
hub 1-0:1.0: USB hub found<br>
hub 1-0:1.0: 2 ports detected<br>
hub 1-0:1.0: standalone hub<br>
hub 1-0:1.0: individual port power switching<br>
hub 1-0:1.0: individual port over-current protection<br>
hub 1-0:1.0: Single TT<br>
hub 1-0:1.0: TT requires at most 8 FS bit times<br>
hub 1-0:1.0: power on to power good time: 20ms<br>
hub 1-0:1.0: local power source is good<br>
hub 1-0:1.0: enabling power on all ports<br>
2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (Au1xxx)<br>
block sizes: ed 64 td 64<br>
hub 1-0:1.0: state 5 ports 2 chg 0006 evt 0007<br>
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 001403 POWER sig=k&nbsp; CSC CONNECT<br>
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s<br>
In ohci_hcd_au1xxx_drv_probe<br>
drivers/usb/host/ohci-au1xxx.c: starting Au1xxx OHCI USB Controller<br>
drivers/usb/host/ohci-au1xxx.c: Clock to USB host has been enabled<br>
ohci_hcd (Au1xxx) at 0xb4020100, irq 29<br>
au1xxx-ohci au1xxx-ohci0: new USB bus registered, assigned bus number 2<br>
au1xxx-ohci au1xxx-ohci0: ohci_au1xxx_start, ohci:86e9fcf0<br>
au1xxx-ohci au1xxx-ohci0: resetting from state 'reset', control = 0x0<br>
au1xxx-ohci au1xxx-ohci0: OHCI controller state<br>
au1xxx-ohci au1xxx-ohci0: OHCI 1.0, with legacy support registers<br>
au1xxx-ohci au1xxx-ohci0: control 0x083 HCFS=operational CBSR=3<br>
au1xxx-ohci au1xxx-ohci0: cmdstatus 0x00000 SOC=0<br>
au1xxx-ohci au1xxx-ohci0: intrstatus 0x00000044 RHSC SF<br>
au1xxx-ohci au1xxx-ohci0: intrenable 0x8000001a MIE UE RD WDH<br>
au1xxx-ohci au1xxx-ohci0: hcca frame #0021<br>
au1xxx-ohci au1xxx-ohci0: roothub.a 10000202 POTPGT=16 NPS NDP=2<br>
au1xxx-ohci au1xxx-ohci0: roothub.b 00000000 PPCM=0000 DR=0000<br>
au1xxx-ohci au1xxx-ohci0: roothub.status 00008000 DRWE<br>
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [0] 0x00000100 PPS<br>
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [1] 0x00000100 PPS<br>
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1<br>
usb usb2: default language 0x0409<br>
usb usb2: Product: Au1xxx OHCI<br>
usb usb2: Manufacturer: Linux 2.6.11 ohci_hcd<br>
usb usb2: SerialNumber: au1xxx<br>
usb usb2: hotplug<br>
usb usb2: adding 2-0:1.0 (config #1, interface 0)<br>
usb 2-0:1.0: hotplug<br>
hub 2-0:1.0: usb_probe_interface<br>
hub 2-0:1.0: usb_probe_interface - got id<br>
hub 2-0:1.0: USB hub found<br>
hub 2-0:1.0: 2 ports detected<br>
hub 2-0:1.0: standalone hub<br>
hub 2-0:1.0: no power switching (usb 1.0)<br>
hub 2-0:1.0: global over-current protection<br>
hub 2-0:1.0: power on to power good time: 32ms<br>
hub 2-0:1.0: local power source is good<br>
hub 2-0:1.0: no over-current condition exists<br>
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501<br>
au1xxx-ehci au1xxx-ehci0: port 1 low speed --&gt; companion<br>
au1xxx-ohci au1xxx-ohci0: created debug files<br>
Initializing USB Mass Storage driver...<br>
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 003002 POWER OWNER sig=se0&nbsp; CSC<br>
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s<br>
hub 2-0:1.0: state 5 ports 2 chg 0006 evt 0007<br>
usbcore: registered new driver usb-storage<br>
USB Mass Storage support registered.<br>
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS<br>
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s<br>
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301<br>
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS<br>
usb 2-1: new low speed USB device using au1xxx-ohci and address 2<br>
ghzhang: USB inserted<br>
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS<br>
usb 2-1: skipped 1 descriptor after interface<br>
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0<br>
usb 2-1: default language 0x0409<br>
usb 2-1: Product: HP Basic USB Keyboard<br>
usb 2-1: Manufacturer: CHICONY<br>
usb 2-1: hotplug<br>
usb 2-1: adding 2-1:1.0 (config #1, interface 0)<br>
usb 2-1:1.0: hotplug<br>
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s<br>
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0002<br>
usbhid 2-1:1.0: usb_probe_interface<br>
usbhid 2-1:1.0: usb_probe_interface - got id<br>
input: USB HID v1.10 Keyboard [CHICONY HP Basic USB Keyboard] on usb-au1xxx-1<br>
usbcore: registered new driver usbhid<br>
drivers/usb/input/hid-core.c: v2.0:USB HID core driver<br>
drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2 (2004/08/27)<br>
usbcore: registered new driver rtl8150<br>
usbcore: registered new driver usblcd<br>
drivers/usb/misc/usblcd.c: USBLCD Driver Version 1.04 (C) Adams IT Services <a href="http://www.usblcd.de" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.usblcd.de</a><br>
drivers/usb/misc/usblcd.c: USBLCD support registered.<br>
usbcore: registered new driver usbled<br>
usbcore: registered new driver usbtest<br>
<br>
-----------------------------------------------------------------------------------------------------<br>
cat /proc/bus/input/devices<br>
<br>
I: Bus=0003 Vendor=03f0 Product=0024 Version=0300<br>
N: Name=&quot;CHICONY HP Basic USB Keyboard&quot;<br>
P: Phys=usb-au1xxx-1/input0<br>
H: Handlers=event0<br>
B: EV=120013<br>
B: KEY=10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe<br>
B: MSC=10<br>
B: LED=7<br>
----------------------------------------------------------------------------<br>
<br>
CAN ANYBODY HELP ME IN THIS REGARD,<br>
<br>
Is there anything to do with &quot;keybdev&quot; and &quot;/sbin/hotplug&quot;?????<br>
<br>
Both of these are not present on my system<br>
<br>
Thanking you in advance,<br>
M.Chandrashekar<br>

------=_Part_3741_24166097.1164697850680--
