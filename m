Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2008 14:36:40 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.153]:15303 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20029203AbYA1Oga (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jan 2008 14:36:30 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1696958fga.32
        for <linux-mips@linux-mips.org>; Mon, 28 Jan 2008 06:36:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=HPMiAYdqQm9UVrXNZdbi4xim2RO2ZJemBuvRzmNMBe4=;
        b=FaLlUG0ypRxZ6cjgrCv74LPZJpAgDw37O6Jqk57Lz3bYJKvmTZLALiWX36A4csfX4WEd9M6XCVuKQtQRk3gCWDGMViUjSyl3To7oV+KungiS7l0RqYeHA8Iy0OlaOGhDb1sqKsMaJ7eSHrjvwbYeYVK85HhI/WBOmPS7hd2r21c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=W0Abdt3GQrKRcIowkzI5KT+pLC307VuCtkbcL8WCesjNvJbUF+fLZKELPHwptgZtxj02sucTeqMNIyCjU35KTUthaNGtjDlzNRrj5bt0yBnXXdCfKAFyfPba6PFDEmHiyjSB4MpgxHlVtoIvPFpk2KO9dBao83rzT2+eT9QaXDA=
Received: by 10.86.86.12 with SMTP id j12mr5248869fgb.50.1201530989623;
        Mon, 28 Jan 2008 06:36:29 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.30.56])
        by mx.google.com with ESMTPS id d4sm5942331fga.2.2008.01.28.06.36.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jan 2008 06:36:27 -0800 (PST)
Message-ID: <479DE866.4040709@gmail.com>
Date:	Mon, 28 Jan 2008 17:36:22 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] [MIPS] Malta: massive code cleanup
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com> <20080128143300.GA376@linux-mips.org>
In-Reply-To: <20080128143300.GA376@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle пишет:
> On Thu, Jan 24, 2008 at 07:52:40PM +0300, Dmitri Vorobiev wrote:
> 
> Whole series queued for 2.6.25.

OK, thanks.

Dmitri

> 
> Thanks,
> 
>   Ralf
> 
