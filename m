Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g55GVBnC005909
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 5 Jun 2002 09:31:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g55GVBD1005908
	for linux-mips-outgoing; Wed, 5 Jun 2002 09:31:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g55GV7nC005863
	for <linux-mips@oss.sgi.com>; Wed, 5 Jun 2002 09:31:08 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g55HO6DS002883;
	Wed, 5 Jun 2002 18:24:07 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g55HO28D002871;
	Wed, 5 Jun 2002 18:24:02 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: kmalloc question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
In-Reply-To: <86048F07C015D311864100902760F1DD01B5EA6B@DLFW003A>
References: <86048F07C015D311864100902760F1DD01B5EA6B@DLFW003A>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 18:24:02 +0100
Message-Id: <1023297842.2443.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2002-06-05 at 06:25, Andre.Messerschmidt@infineon.com wrote:
> Hi.
> 
> I always thought that it is save to use kmalloc in an interrupt handler as
> long as you use GFP_ATOMIC. 
> Now someone told me that it is not allowed to use these functions in any way
> in an interrupt.
> 
> Can please someone clarify me here? 

GFP_ATOMIC is safe in an interrupt handler. You might get NULL back and
that it is your problem, but the kmalloc is safe
