Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5QMH7k32212
	for linux-mips-outgoing; Tue, 26 Jun 2001 15:17:07 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5QMH6V32209
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 15:17:06 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5QMH1029355;
	Tue, 26 Jun 2001 15:17:01 -0700
Message-ID: <3B390949.7B300BD1@mvista.com>
Date: Tue, 26 Jun 2001 15:14:33 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: PATCH: support for Vr41xx cpu family and Vr4181/Osprey
References: <3B38EDC6.3ADB8148@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I just realize the previous email makes me greater than who really I am. :-)

The VR41XX generic support is a combination of my work and Yoichi Yuasa.  Most
of the Vr4181/Osprey stuff is stolen from Linux-VR tree but restructured in a
way to better support future Vr4181-based systems (such as Agenda VR3, any
takers?).

Also, here is a todo list:

. use the new IRQ
. use new the new time.c
. use the standard serial
. add sound, framebuffer and touch panel for Vr4181

The sound driver should be similar to Vrc5477 ac97 sound driver that I put in
recently.

Jun
