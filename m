Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KFldEC031103
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 08:47:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KFldKf031102
	for linux-mips-outgoing; Tue, 20 Aug 2002 08:47:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from marjan.installco.com (marjan.installco.com [65.39.69.14])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KFlNEC031090
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 08:47:24 -0700
Received: (qmail 21966 invoked by uid 504); 20 Aug 2002 08:36:20 -0000
Received: from tom@tomlogic.com by marjan.installco.com by uid 507 with qmail-scanner-1.12 (spamassassin: 2.30. . Clear:. Processed in 0.326205 secs); 20 Aug 2002 08:36:20 -0000
Received: from unknown (HELO Tom) (130.13.171.182)
  by marjan.installco.com with DES-CBC3-SHA encrypted SMTP; 20 Aug 2002 08:36:19 -0000
Date: Tue, 20 Aug 2002 08:50:18 -0700
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: multipart/alternative; boundary=Apple-Mail-1-11810748
Subject: CONFIG_MIPS_IVR change for arch/mips/config.in
From: Tom Collins <tom@tomlogic.com>
To: linux-mips@oss.sgi.com
Message-Id: <869DF7E0-B454-11D6-8E42-000393B3D1D0@tomlogic.com>
X-Mailer: Apple Mail (2.482)
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Apple-Mail-1-11810748
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

I'm not a subscriber to the list, so if anyone has questions or 
responses, please email me directly.

I have a machine based on the Globespan IVR board, and just got done 
fighting through an upgrade from 2.4.2 to 2.4.19.  In the process, I 
determined that (at least for my configuration), CONFIG_PCI_AUTO should 
not be set.  When set, the I/O mappings for my devices (USB) were out of 
whack, and I was unable to use one of the on-board USB chips.

Here's the configuration as it stands on my machine now:

if [ "$CONFIG_MIPS_IVR" = "y" ]; then
     define_bool CONFIG_PCI y
     define_bool CONFIG_PC_KEYB y
     define_bool CONFIG_NEW_PCI y
     define_bool CONFIG_NONCOHERENT_IO y
     define_bool CONFIG_PCI_AUTO n
     define_bool CONFIG_IT8172_CIR y
     define_bool CONFIG_NEW_IRQ y
     define_bool CONFIG_NEW_TIME_C y
fi

I am still working on a problem with a PCI card on the unit though.  
It's a USB 2.0 interface which appears to the kernel as two OHCI (1.0) 
interfaces and one EHCI (2.0) interface.  Right now, the kernel doesn't 
find the EHCI interface.  If I find that changing other settings (like 
CONFIG_NEW_PCI) results in that interface showing up (without blowing up 
the others), I'll be sure to tell the list.

Can someone here please make sure this change gets into the 2.4.20 
kernel?  I haven't been using the 2.5 kernels because the last one I 
tried (2.5.25) wouldn't compile on my platform.

--
Tom Collins
tom@tomlogic.com

--Apple-Mail-1-11810748
Content-Transfer-Encoding: 7bit
Content-Type: text/enriched;
	charset=US-ASCII

I'm not a subscriber to the list, so if anyone has questions or
responses, please email me directly.


I have a machine based on the Globespan IVR board, and just got done
fighting through an upgrade from 2.4.2 to 2.4.19.  In the process, I
determined that (at least for my configuration), CONFIG_PCI_AUTO
should not be set.  When set, the I/O mappings for my devices (USB)
were out of whack, and I was unable to use one of the on-board USB
chips.


Here's the configuration as it stands on my machine now:


<fixed><color><param>0000,0000,DEDE</param>if [ "$CONFIG_MIPS_IVR" =
"y" ]; then

    define_bool CONFIG_PCI y

    define_bool CONFIG_PC_KEYB y

    define_bool CONFIG_NEW_PCI y

    define_bool CONFIG_NONCOHERENT_IO y

    define_bool CONFIG_PCI_AUTO n

    define_bool CONFIG_IT8172_CIR y

    define_bool CONFIG_NEW_IRQ y

    define_bool CONFIG_NEW_TIME_C y

fi

</color></fixed>

I am still working on a problem with a PCI card on the unit though. 
It's a USB 2.0 interface which appears to the kernel as two OHCI (1.0)
interfaces and one EHCI (2.0) interface.  Right now, the kernel
doesn't find the EHCI interface.  If I find that changing other
settings (like CONFIG_NEW_PCI) results in that interface showing up
(without blowing up the others), I'll be sure to tell the list.


Can someone here please make sure this change gets into the 2.4.20
kernel?  I haven't been using the 2.5 kernels because the last one I
tried (2.5.25) wouldn't compile on my platform.


--

Tom Collins

tom@tomlogic.com
--Apple-Mail-1-11810748--
