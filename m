Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 21:18:44 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.240]:20578 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20025722AbXJCUSL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 21:18:11 +0100
Received: by ag-out-0708.google.com with SMTP id 33so2589671agc
        for <linux-mips@linux-mips.org>; Wed, 03 Oct 2007 13:17:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eDQ28wdb8rCuymqOJ9RUoerhaBEua/51uc6GXGql3LY=;
        b=k5QWphMSK6hzo9wCeEBz3G9RbZIXQn30Fw7X5eWPm2RpNDpTk3iGOV0r3JMOkJBNj/NL5nszZ+TVC32xHpZMRLugHykp/tMSjQ+yMST8jU4mzv1w31gVnFhIdnDK4y5wlD7guo3+U+I7bjHt3jvu9l3GHFXp9e6kea7kSDpa5Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iTj9UovDEdR/wfjh0oR5A9e8oKKWcIu81CNxL8sP9Z6nCcH7pvIQsTIHSdqDIejQCoD1hGBD6gVaTbrDlE9wFrz4Ng8DpMcvM4akReg2q5TQT7MxJC2WrOynrfWa3YRyFQt8aFxVuz0PqghIz3jdL3kAE8JuekPYgT0MPj6rO+4=
Received: by 10.90.90.3 with SMTP id n3mr209084agb.1191442672979;
        Wed, 03 Oct 2007 13:17:52 -0700 (PDT)
Received: by 10.90.83.9 with HTTP; Wed, 3 Oct 2007 13:17:52 -0700 (PDT)
Message-ID: <40101cc30710031317n360ea4c7y6491f549c62e3edb@mail.gmail.com>
Date:	Wed, 3 Oct 2007 22:17:52 +0200
From:	"Matteo Croce" <technoboy85@gmail.com>
To:	"Wim Van Sebroeck" <wim@iguana.be>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Cc:	linux-mips@linux-mips.org, "Nicolas Thill" <nico@openwrt.org>,
	"Enrik Berkhan" <Enrik.Berkhan@akk.org>,
	"Christer Weinigel" <wingel@nano-system.com>,
	"Andrew Morton" <akpm@linux-foundation.org>
In-Reply-To: <20071003192414.GA7543@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200709201728.10866.technoboy85@gmail.com>
	 <200709201806.41942.technoboy85@gmail.com>
	 <20071003192414.GA7543@infomag.infomag.iguana.be>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

> If you want I'll add it to the linux-2.6-watchdog-mm tree with
> the above mentioned changes.
Yes, please
Cheers
