Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 22:21:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:51707 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225239AbTEHVVe>;
	Thu, 8 May 2003 22:21:34 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA02403;
	Thu, 8 May 2003 14:21:28 -0700
Message-ID: <3EBACA58.3050303@mvista.com>
Date: Thu, 08 May 2003 14:21:28 -0700
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: baitisj@evolution.com
CC: Pete Popov <ppopov@mvista.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: USB OHCI device port on Alchemy
References: <20030507203127.U30468@luca.pas.lab> <1052415629.558.91.camel@zeus.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090100010504090006050707"
Return-Path: <stevel@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stevel@mvista.com
Precedence: bulk
X-list: linux-mips


This is a multi-part message in MIME format.
--------------090100010504090006050707
Content-Type: multipart/alternative;
 boundary="------------070000070702080909070203"



--------------070000070702080909070203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Pete Popov wrote:

>On Wed, 2003-05-07 at 20:31, Jeff Baitis wrote:
>  
>
>>Out of curiousity:
>>
>>Has anyone played with the AU1X00 USB device port yet? If not, what would you
>>guys suggest that the AU1X00 appear as? USB over Ethernet? Or maybe a simple
>>dummy device that will perform bulk transfers?
>>    
>>
>
>Steve wrote it, tried, knows all about it :)
>

Hi Jeff,

Ok, so there's more interest in this driver than I expected, so I guess
it's high time I write some docs for it under Documentation/mips
somewhere.

In the meantime, attached are some instructions on how to use the TTY
function driver.

In answer to your questions, there is no USB over ethernet function
driver. But I did write a "raw" function driver that simply presents
a bulk IN and bulk OUT endpoint for raw bulk data transfer. I will
write up some instructions on that as well.

Steve

-- 
Steve Longerbeam
MontaVista Software, Inc.
office:408-328-9008, fax:408-328-3875
http://www.mvista.com



--------------070000070702080909070203
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
<br>
<br>
Pete Popov wrote:<br>
<blockquote type="cite"
 cite="mid1052415629.558.91.camel@zeus.mvista.com">
  <pre wrap="">On Wed, 2003-05-07 at 20:31, Jeff Baitis wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Out of curiousity:

Has anyone played with the AU1X00 USB device port yet? If not, what would you
guys suggest that the AU1X00 appear as? USB over Ethernet? Or maybe a simple
dummy device that will perform bulk transfers?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Steve wrote it, tried, knows all about it :)</pre>
</blockquote>
<br>
Hi Jeff,<br>
<br>
Ok, so there's more interest in this driver than I expected, so I guess<br>
it's high time I write some docs for it under Documentation/mips<br>
somewhere.<br>
<br>
In the meantime, attached are some instructions on how to use the TTY<br>
function driver.<br>
<br>
In answer to your questions, there is no USB over ethernet function<br>
driver. But I did write a "raw" function driver that simply presents<br>
a bulk IN and bulk OUT endpoint for raw bulk data transfer. I will<br>
write up some instructions on that as well.<br>
<br>
Steve<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Steve Longerbeam
MontaVista Software, Inc.
office:408-328-9008, fax:408-328-3875
<a class="moz-txt-link-freetext" href="http://www.mvista.com">http://www.mvista.com</a>
</pre>
<br>
</body>
</html>

--------------070000070702080909070203--

--------------090100010504090006050707
Content-Type: text/plain;
 name="au1x00_usbdev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1x00_usbdev.txt"

Instructions for using the Au1x00 USB TTY Function driver
---------------------------------------------------------

Note: These instructions assume the use of a Pb1500 reference board
(Au1500) but should work with the Pb1000, Pb1100, and Db1x00
boards as well (but is untested on these boards).

Follow these steps:

1.   cp arch/mips/configs/defconfig-pb1500 .config
     make oldconfig
     make menuconfig
     (enable 'Au1000 USB TTY Device support' under char devices as built-in).
     make dep; make
     mips_fp_le-objcopy -O srec vmlinux /tftpboot/vmlinux.s3

2. Now you have a kernel with the Au1x00 USB device TTY driver
   support built-in. Boot a Pb1500 with this kernel.

3. Now you have a choice, you can use a PC as the USB host,
   or a Pb1x00. I have used both a PC and two Pb1500s side-by-side,
   one as the USB host and one as the TTY device. Remember that
   if you use another Pb1000/Pb1500 as the USB host, you'll need
   seperate NFS servers to provide two completely seperate root
   filesystems.

4. On the USB host, enable usbserial generic support as a module. Under
   "USB support -->", go to "USB Serial Converter support  --->" and
   enable "USB Serial Converter support" as a module, then enable
   "USB Generic Serial Driver".
   
5. Install the usbserial module on the host:

     insmod usbserial vendor=0x6d04 product=0x0bc0

6. Make sure you've got the usb TTY nodes on your host:

     mknod /dev/ttyUSB0 c 188 0
     mknod /dev/ttyUSB1 c 188 1

7. On the USB device, make the usb TTY device nodes:

     mknod /dev/ttyUSBdev0 c 189 0
     mknod /dev/ttyUSBdev1 c 189 1

8. Now you should be ready to connect host to device. You can
    tail -f /var/log/kern.log on both sides to watch the progress of
    communication on the control endpoint 0. When the device is
    configured, you should see something about "usbserial attached"
    on the host, and:

Jan  1 00:01:31 10 kernel: usbdev.c: do_setup: req 9 SET_CONFIGURATION
Jan  1 00:01:31 10 kernel: usbdev.c: set config, config=1

    on the device.

9. Now you can try actually communicating over the TTY ports. Try
    running minicom on both sides, the host minicom opens
    /dev/ttyUSB0, the device minicom opens /dev/ttyUSBdev0. Type
    into either minicom window and you should see the characters
    appear on the other side.

10. Try starting a getty login process on either side. On the host:

     getty ttyUSB0 &

     and on the device:

     getty ttyUSBdev0 &

     You should then see a login prompt in minicom on the opposite
     sides.

11. Try echoing strings to the other side:

     echo hello world > /dev/ttyUSB0    # hello world should appear in minicom on device-side

     echo hello world > /dev/ttyUSBdev0    # hello world should appear in minicom on host-side

12. You can try the above minicom/getty/echo tests on port 1, but last
    I checked, endpoints 4 and 5 (which make up port 1) were still
    having problems.

--------------090100010504090006050707--
