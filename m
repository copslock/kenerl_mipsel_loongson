Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 09:29:52 +0000 (GMT)
Received: from web32906.mail.mud.yahoo.com ([68.142.206.53]:50832 "HELO
	web32906.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133600AbVLEJ30 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 09:29:26 +0000
Received: (qmail 36426 invoked by uid 60001); 5 Dec 2005 09:28:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5cP+BWazWuSF6ZB4Xd/h+KgcADANXMgaS9uy2VOd0eWmzLULr1JLW8eYD8DGJkGQHOGVpCcTbQmYzgQiWcmyEeVSGY1WtQWGaZPUkOr+BirsNiCJ2v/IhL/RZqzSm5s8pH6+DzY1CCZ8uqJvSe+P/fpbMqomUEIs/NbgkSpM7Co=  ;
Message-ID: <20051205092855.36424.qmail@web32906.mail.mud.yahoo.com>
Received: from [203.145.155.11] by web32906.mail.mud.yahoo.com via HTTP; Mon, 05 Dec 2005 01:28:55 PST
Date:	Mon, 5 Dec 2005 01:28:55 -0800 (PST)
From:	Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] ALCHEMY:  Alchemy Camera Interface (CIM) driver
To:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
In-Reply-To: <20051202190635.GI28227@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <komal_shah802003@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: komal_shah802003@yahoo.com
Precedence: bulk
X-list: linux-mips

--- Jordan Crouse <jordan.crouse@amd.com> wrote:

and values
> */
> +} CAMERA;
> +
> +
> +
> +static CAMERA au1xxx_cameras[] = {
> +	/* Omnivision OV9640 Camera 1280x960 Mode (SXGA) in "Pass Thru
> Mode"
> +	   1.3 MP at 15 Fps
> +	*/

There is already nice way to separate sensor interface from the camera
core and ov9640 camera sensor driver is available at OMAP tree.

Could you please look at that and see if that can be re-used?
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=c7691d19356f9c5d8cb724a924e8bdebaed7fc65;hb=279a7045accc927dbb2b1d41691424c4d345489c;f=drivers/media/video/omap/sensor_ov9640.c


---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 
