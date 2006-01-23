Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 16:00:19 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:58277 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S3465572AbWAWP75 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 15:59:57 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id BCB95707FE;
	Mon, 23 Jan 2006 17:04:08 +0100 (CET)
Received: from schenk.isar.de (host-82-135-47-202.customer.m-online.net [82.135.47.202])
	by mail.m-online.net (Postfix) with ESMTP id AA18E92957;
	Mon, 23 Jan 2006 17:04:08 +0100 (CET)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id k0NG46a26735;
	Mon, 23 Jan 2006 17:04:08 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (Postfix) with ESMTP id 80A16BF5BC;
	Mon, 23 Jan 2006 17:04:06 +0100 (CET)
Message-ID: <43D4FE76.1070805@rtschenk.de>
Date:	Mon, 23 Jan 2006 17:04:06 +0100
From:	Rojhalat Ibrahim <imr@rtschenk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
References: <20060123150507.GA18665@linux-mips.org>
In-Reply-To: <20060123150507.GA18665@linux-mips.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imr@rtschenk.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imr@rtschenk.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> below.
> 

Works for me. The compilation errors are gone and the kernel
seems to be running fine.

Thanks
Rojhalat Ibrahim
