Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 05:56:11 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:18438
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226113AbVGAEzy>;
	Fri, 1 Jul 2005 05:55:54 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57DF9.55978810"
Subject: RE: Problems with Intel e100 driver on new MIPS port, was: Advice needed WRT very slow nfs in new port...
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date:	Thu, 30 Jun 2005 21:57:08 -0700
Message-ID: <01049E563C8ECC43AD6B53A5AF419B38098BD1@avtrex-server2.hq2.avtrex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with Intel e100 driver on new MIPS port, was: Advice needed WRT very slow nfs in new port...
thread-index: AcV9oSR1XQkpRJenRl6RKFHbK/oEhgAVveT6
From:	"David Daney" <ddaney@avtrex.com>
To:	"Michael Stickel" <michael@cubic.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C57DF9.55978810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

David Daney wrote:
>Michael Stickel wrote:
>> M. Warner Losh wrote:
>>
>>> In message: <42C359F8.4060000@avtrex.com>
>>>            David Daney <ddaney@avtrex.com> writes:
>>> : M. Warner Losh wrote:
>>> : > In message: <42C34C4D.9020902@avtrex.com>
>>> : >             David Daney <ddaney@avtrex.com> writes:
>>> : > : Does anyone have any idea what would cause 1000mS delay?
>>> : > : > That's remarkably close to 1s.  This often indicates that =
the
>>> transmit
>>> : > of your next packet is causing the receive buffer to empty.  =
This is
>>> : > usually due to blocked interrupts, or a failure to enable =
interrupts.
>>> : > : : But I observe ever increasing counts for the device in
>>> /proc/interrupts. :   So the interrupts are working somewhat.
>>>
>>> Are you sure that you've routed the interrupts correctly?  Maybe =
those
>>> interrupts are 'really' for a different device....
>>>=20
>>>
>> Add some debugging to the interrupt routine of the e100 and see what
>> happens.
>
>The interrupt routine is getting called each time a packet is received.
>
>It looks like packets are not being transmitted until the interrupt for
>the the received packet is received.
>
>If I ping the board at different intervals the round trip time is =
always
>almost exactly equal to the ping interval.  So if I ping every 50mS the
>round trip time is 50mS, ping every 200mS gives a RTT of 200mS, etc.
>
>Any more ideas?
>
>I am thinking that perhaps the CPU write-back-queue is interfearing =
with
>writes to the NIC's registers.  Perhaps I will try to disable it.

I think I solved the problem.

It seems that it is a memory consistancy problem of some sort.  By =
placing wbflush() after all writes to NIC registers it works.  This =
leads me to think that either the driver is buggy WRT processors that =
have write-back queues or my implementation (the default implementation) =
of writeb() and friends is buggy on this processor.  Now it could be =
that all that is needed is wmb() before some of the register writes, but =
since on my processor they both do the same thing (sync) it is hard to =
tell.

That will be the subject of my next message.

David Daney



------_=_NextPart_001_01C57DF9.55978810
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">=0A=
<TITLE>Re: Problems with Intel e100 driver on new MIPS port, was: Advice =
needed WRT very slow nfs in new port...</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr><FONT size=3D2>David Daney wrote:</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>&gt;Michael Stickel wrote:<BR>&gt;&gt; M. =
Warner Losh =0A=
wrote:<BR>&gt;&gt;<BR>&gt;&gt;&gt; In message: =0A=
&lt;42C359F8.4060000@avtrex.com&gt;<BR>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
David Daney &lt;ddaney@avtrex.com&gt; writes:<BR>&gt;&gt;&gt; : M. =
Warner Losh =0A=
wrote:<BR>&gt;&gt;&gt; : &gt; In message: =0A=
&lt;42C34C4D.9020902@avtrex.com&gt;<BR>&gt;&gt;&gt; : =0A=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =0A=
David Daney &lt;ddaney@avtrex.com&gt; writes:<BR>&gt;&gt;&gt; : &gt; : =
Does =0A=
anyone have any idea what would cause 1000mS delay?<BR>&gt;&gt;&gt; : =
&gt; : =0A=
&gt; That's remarkably close to 1s.&nbsp; This often indicates that =0A=
the<BR>&gt;&gt;&gt; transmit<BR>&gt;&gt;&gt; : &gt; of your next packet =
is =0A=
causing the receive buffer to empty.&nbsp; This is<BR>&gt;&gt;&gt; : =
&gt; =0A=
usually due to blocked interrupts, or a failure to enable =0A=
interrupts.<BR>&gt;&gt;&gt; : &gt; : : But I observe ever increasing =
counts for =0A=
the device in<BR>&gt;&gt;&gt; /proc/interrupts. :&nbsp;&nbsp; So the =
interrupts =0A=
are working somewhat.<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; Are you sure that =
you've =0A=
routed the interrupts correctly?&nbsp; Maybe those<BR>&gt;&gt;&gt; =
interrupts =0A=
are 'really' for a different =0A=
device....<BR>&gt;&gt;&gt;&nbsp;<BR>&gt;&gt;&gt;<BR>&gt;&gt; Add some =
debugging =0A=
to the interrupt routine of the e100 and see what<BR>&gt;&gt; =0A=
happens.<BR>&gt;<BR>&gt;The interrupt routine is getting called each =
time a =0A=
packet is received.<BR>&gt;<BR>&gt;It looks like packets are not being =0A=
transmitted until the interrupt for<BR>&gt;the the received packet is =0A=
received.<BR>&gt;<BR>&gt;If I ping the board at different intervals the =
round =0A=
trip time is always<BR>&gt;almost exactly equal to the ping =
interval.&nbsp; So =0A=
if I ping every 50mS the<BR>&gt;round trip time is 50mS, ping every =
200mS gives =0A=
a RTT of 200mS, etc.<BR>&gt;<BR>&gt;Any more ideas?<BR>&gt;<BR>&gt;I am =
thinking =0A=
that perhaps the CPU write-back-queue is interfearing with<BR>&gt;writes =
to the =0A=
NIC's registers.&nbsp; Perhaps I will try to disable it.<BR></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>I think I solved the problem.</FONT></DIV>=0A=
<P><FONT size=3D2>It seems that it is a memory consistancy problem of =
some =0A=
sort.&nbsp; By placing</FONT><FONT size=3D2>&nbsp;wbflush() after all =
writes to =0A=
NIC registers it works.&nbsp; This leads me to think that either the =
driver is =0A=
buggy WRT processors that have write-back queues or my implementation =
(the =0A=
default implementation) of writeb() and friends is buggy on this =0A=
processor.&nbsp; Now it could be that all that is needed is wmb() before =
some of =0A=
the register writes, but since on my processor they both do the same =
thing =0A=
(sync) it is hard to tell.</FONT></P>=0A=
<P><FONT size=3D2>That will be the subject of my next message.</FONT></P>=0A=
<P><FONT size=3D2>David Daney</P>=0A=
<DIV dir=3Dltr><BR></DIV></FONT>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C57DF9.55978810--
