Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 08:51:08 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:65480 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133600AbVLEIup (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 08:50:45 +0000
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 6267DC018;
	Mon,  5 Dec 2005 09:50:14 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 2FFF81BC08A;
	Mon,  5 Dec 2005 09:50:16 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 319021A18A7;
	Mon,  5 Dec 2005 09:50:16 +0100 (CET)
Subject: Re: [PATCH] ALCHEMY:  Alchemy Camera Interface (CIM) driver
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20051202190635.GI28227@cosmic.amd.com>
References: <20051202190635.GI28227@cosmic.amd.com>
Content-Type: text/plain
Date:	Mon, 05 Dec 2005 09:49:27 +0100
Message-Id: <1133772567.2377.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> A driver for the AU1200 Camera Interface (CIM).  

Great news!

> I'm sending up right now, so comments and flames are definately
> welcome.

Wouldn't it be wise to support V4L2?
This way, many existing application could use AU1200s camera interface.


> +int __init
> +au1xxxcim_init(void)
> +{
> +	int retval, error;
> +	unsigned long page;
> +	CAMERA_RUNTIME *cam_init;
> +	CAMERA *cim_ptr;
> +
> +	cam_init = &cam_base;
> +	cam_init->cmos_camera = OrigCimArryPtr + prev_mode;
> +	cim_ptr = cam_init->cmos_camera;
> +
> +	/*Allocating memory for MMAP */
> +	mem_buf = (unsigned long *)Camera_mem_alloc(2 * MAX_FRAME_SIZE);
> +	if (mem_buf == NULL) {
> +		printk(KERN_ERR "MMAP unable to allocate memory \n");
> +	}

IMHO this is a waste of memory, because if the user is going to use
the camera in 320x240 mode and this allocates memory for the biggest
size. Wouldn't it be better to set some default configuration and
allocate memory for this? Later if the user changes the mode those
pages are freed and new (for requested size) are allocated.
Or even allocate memory AFTER the configuration has been set?

BR,
Matej
