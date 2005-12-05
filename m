Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 14:58:57 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:44777 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133644AbVLEO63 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2005 14:58:29 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB5Evx2s015007;
	Mon, 5 Dec 2005 06:58:00 -0800
Received: from 139.95.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 05 Dec 2005 06:57:49 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB5EvlQe005905; Mon, 5
 Dec 2005 06:57:47 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id E683B2026; Mon, 5 Dec 2005
 07:57:46 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB5F6IHi014896; Mon, 5 Dec 2005 08:06:18
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB5F6Iu0014895; Mon, 5 Dec 2005 08:06:18 -0700
Date:	Mon, 5 Dec 2005 08:06:18 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Matej Kupljen" <matej.kupljen@ultra.si>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ALCHEMY:  Alchemy Camera Interface (CIM) driver
Message-ID: <20051205150617.GQ28227@cosmic.amd.com>
References: <20051202190635.GI28227@cosmic.amd.com>
 <1133772567.2377.11.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1133772567.2377.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8A8AE71K82502146-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 05/12/05 09:49 +0100, Matej Kupljen wrote:

> Wouldn't it be wise to support V4L2?
> This way, many existing application could use AU1200s camera interface.

Thats possible, but for now this solution has been reasonable enough for
us to send it upstream.  I'm sure that somebody more familiar with V4L2 could
make short work of adapting it to the existing infrastructure.
 
> > +int __init
> > +au1xxxcim_init(void)
> > +{
> > +	int retval, error;
> > +	unsigned long page;
> > +	CAMERA_RUNTIME *cam_init;
> > +	CAMERA *cim_ptr;
> > +
> > +	cam_init = &cam_base;
> > +	cam_init->cmos_camera = OrigCimArryPtr + prev_mode;
> > +	cim_ptr = cam_init->cmos_camera;
> > +
> > +	/*Allocating memory for MMAP */
> > +	mem_buf = (unsigned long *)Camera_mem_alloc(2 * MAX_FRAME_SIZE);
> > +	if (mem_buf == NULL) {
> > +		printk(KERN_ERR "MMAP unable to allocate memory \n");
> > +	}
> 
> IMHO this is a waste of memory, because if the user is going to use
> the camera in 320x240 mode and this allocates memory for the biggest
> size. Wouldn't it be better to set some default configuration and
> allocate memory for this? Later if the user changes the mode those
> pages are freed and new (for requested size) are allocated.
> Or even allocate memory AFTER the configuration has been set?

I agree, that could be handled better.

Thanks,

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
