Received:  by oss.sgi.com id <S553808AbQKQBQT>;
	Thu, 16 Nov 2000 17:16:19 -0800
Received: from [206.207.108.63] ([206.207.108.63]:27481 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S553675AbQKQBQD>; Thu, 16 Nov 2000 17:16:03 -0800
Received: (qmail 31550 invoked from network); 16 Nov 2000 18:15:51 -0700
Received: from stevej-lx.ridgerun.cxm (HELO ridgerun.com) (stevej@192.168.1.4)
  by ridgerun-lx.ridgerun.cxm with SMTP; 16 Nov 2000 18:15:51 -0700
Message-ID: <3A1486C7.408C50DE@ridgerun.com>
Date:   Thu, 16 Nov 2000 18:15:51 -0700
From:   Steve Johnson <stevej@ridgerun.com>
Organization: Ridgerun, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: MIPS config.in NET configuration
Content-Type: multipart/mixed;
 boundary="------------E67C727199CC0F7C045E6927"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------E67C727199CC0F7C045E6927
Content-Type: multipart/alternative;
 boundary="------------015809693C09D4C35C44B073"


--------------015809693C09D4C35C44B073
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

    I'm trying to add support for a Galileo Tech. EV64120A board,
building on Pete Popov's work that's already in CVS.  I'm having trouble
with the "Network device support" menu when I "make xconfig".

    If I select "Galileo EV96100 Evaluation board" on the "Machine
selection" menu, I can't select PPP support in the "Network device
support" menu because the IP22/Decstation/Baget code in
arch/mips/config.in eclipses the normal net menu's CONFIG_PPP.  Is there
a reasonable way to resolve two different environments needing the same
variable defined?

    The same problem exists for CONFIG_SERIAL, which is defined by the
Decstation and doesn't let me use the normal character device 16550 UART
menu item.

    Please note that this is only a problem for "make xconfig".  "make
menuconfig" works correctly and selects one set of responses for network
devices based on the machine selection.  Is that the solution, that
everyone in MIPS uses "make menuconfig"?

if [ "$CONFIG_NET" = "y" ]; then
   mainmenu_option next_comment
   comment 'Network device support'

   bool 'Network device support' CONFIG_NETDEVICES
   if [ "$CONFIG_NETDEVICES" = "y" ]; then

      if [ "$CONFIG_SGI_IP22" != "y" -a \
          "$CONFIG_DECSTATION" != "y" -a \
    "$CONFIG_BAGET_MIPS" != "y" ]; then

  source drivers/net/Config.in

  if [ "$CONFIG_ATM" = "y" ]; then
     source drivers/atm/Config.in
  fi
      else
  tristate 'Dummy net driver support' CONFIG_DUMMY
  tristate 'SLIP (serial line) support' CONFIG_SLIP
  if [ "$CONFIG_SLIP" != "n" ]; then
     bool ' CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
     bool ' Keepalive and linefill' CONFIG_SLIP_SMART
  fi
  tristate 'PPP (point-to-point) support' CONFIG_PPP
  if [ ! "$CONFIG_PPP" = "n" ]; then
     comment 'CCP compressors for PPP are only built as modules.'
  fi
         if [ "$CONFIG_SGI_IP22" = "y" ]; then
     bool 'SGI Seeq ethernet controller support' CONFIG_SGISEEQ
  fi
  if [ "$CONFIG_DECSTATION" = "y" ]; then
     bool 'DEC LANCE ethernet controller support' CONFIG_DECLANCE
  fi
  if [ "$CONFIG_BAGET_MIPS" = "y" ]; then
     tristate 'Baget AMD LANCE support' CONFIG_BAGETLANCE
  fi
      fi
   fi
   endmenu
fi


    Steve


--------------015809693C09D4C35C44B073
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Hi,
<p>&nbsp;&nbsp;&nbsp; I'm trying to add support for a Galileo Tech. EV64120A
board, building on Pete Popov's work that's already in CVS.&nbsp; I'm having
trouble with the "Network device support" menu when I "make xconfig".
<p>&nbsp;&nbsp;&nbsp; If I select "Galileo EV96100 Evaluation board" on
the "Machine selection" menu, I can't select PPP support in the "Network
device support" menu because the IP22/Decstation/Baget code in arch/mips/config.in
eclipses the normal net menu's CONFIG_PPP.&nbsp; Is there a reasonable
way to resolve two different environments needing the same variable defined?
<p>&nbsp;&nbsp;&nbsp; The same problem exists for CONFIG_SERIAL, which
is defined by the Decstation and doesn't let me use the normal character
device 16550 UART menu item.
<p>&nbsp;&nbsp;&nbsp; Please note that this is only a problem for "make
xconfig".&nbsp; "make menuconfig" works correctly and selects one set of
responses for network devices based on the machine selection.&nbsp; Is
that the solution, that everyone in MIPS uses "make menuconfig"?
<p><tt>if [ "$CONFIG_NET" = "y" ]; then</tt>
<br><tt>&nbsp;&nbsp; mainmenu_option next_comment</tt>
<br><tt>&nbsp;&nbsp; comment 'Network device support'</tt><tt></tt>
<p><tt>&nbsp;&nbsp; bool 'Network device support' CONFIG_NETDEVICES</tt>
<br><tt>&nbsp;&nbsp; if [ "$CONFIG_NETDEVICES" = "y" ]; then</tt><tt></tt>
<p><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ "$CONFIG_SGI_IP22" != "y" -a
\</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "$CONFIG_DECSTATION"
!= "y" -a \</tt>
<br><tt>&nbsp;&nbsp;&nbsp; "$CONFIG_BAGET_MIPS" != "y" ]; then</tt><tt></tt>
<p><tt>&nbsp; source drivers/net/Config.in</tt><tt></tt>
<p><tt>&nbsp; if [ "$CONFIG_ATM" = "y" ]; then</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; source drivers/atm/Config.in</tt>
<br><tt>&nbsp; fi</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</tt>
<br><tt>&nbsp; tristate 'Dummy net driver support' CONFIG_DUMMY</tt>
<br><tt>&nbsp; tristate 'SLIP (serial line) support' CONFIG_SLIP</tt>
<br><tt>&nbsp; if [ "$CONFIG_SLIP" != "n" ]; then</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; bool ' CSLIP compressed headers' CONFIG_SLIP_COMPRESSED</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; bool ' Keepalive and linefill' CONFIG_SLIP_SMART</tt>
<br><tt>&nbsp; fi</tt>
<br><tt>&nbsp; tristate 'PPP (point-to-point) support' CONFIG_PPP</tt>
<br><tt>&nbsp; if [ ! "$CONFIG_PPP" = "n" ]; then</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; comment 'CCP compressors for PPP are only
built as modules.'</tt>
<br><tt>&nbsp; fi</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ "$CONFIG_SGI_IP22"
= "y" ]; then</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; bool 'SGI Seeq ethernet controller support'
CONFIG_SGISEEQ</tt>
<br><tt>&nbsp; fi</tt>
<br><tt>&nbsp; if [ "$CONFIG_DECSTATION" = "y" ]; then</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; bool 'DEC LANCE ethernet controller support'
CONFIG_DECLANCE</tt>
<br><tt>&nbsp; fi</tt>
<br><tt>&nbsp; if [ "$CONFIG_BAGET_MIPS" = "y" ]; then</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp; tristate 'Baget AMD LANCE support' CONFIG_BAGETLANCE</tt>
<br><tt>&nbsp; fi</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi</tt>
<br><tt>&nbsp;&nbsp; fi</tt>
<br><tt>&nbsp;&nbsp; endmenu</tt>
<br><tt>fi</tt>
<br><tt></tt>&nbsp;<tt></tt>
<p>&nbsp;&nbsp;&nbsp; Steve
<br>&nbsp;</html>

--------------015809693C09D4C35C44B073--

--------------E67C727199CC0F7C045E6927
Content-Type: text/x-vcard; charset=us-ascii;
 name="stevej.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Steve Johnson
Content-Disposition: attachment;
 filename="stevej.vcf"

begin:vcard 
n:Johnson;Steve
tel;fax:208-331-2227
tel;work:208-331-2226x11
x-mozilla-html:TRUE
url:http://www.ridgerun.com
org:RidgeRun, Inc.
version:2.1
email;internet:stevej@ridgerun.com
title:Senior Kernel Developer
adr;quoted-printable:;;RidgeRun, Inc.=0D=0A200 N 4th St, Suite 101		;Boise;ID;83702;USA
x-mozilla-cpt:;27936
fn:Steve Johnson
end:vcard

--------------E67C727199CC0F7C045E6927--
