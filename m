Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 12:40:44 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:3852 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022169AbXGILkm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 12:40:42 +0100
Received: by py-out-1112.google.com with SMTP id p76so1985431pyb
        for <linux-mips@linux-mips.org>; Mon, 09 Jul 2007 04:40:40 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YVJxYIeZbkvacZoG90xuXspxONNKBAWU7H85In9nOq0GW+x0vV022nFWAYwCSuBrZBf81BqOAi1Waeb+Wvq5kAbejILBkEhD4Pq7TR1MjLr0fh7Jci22bRpPpY17yAuhYZMLz4sKEubL9v3MaHrSzBTY12EUxypLhILVE8O9TXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q8bKoI5idmQw7i+e/gTMPOZbigyZLg1AhWxA5MKE/XvSl2Y8zeWE4jFKRZwKzAbKEvmMNTlzlvlvjJZC9DvWK0/mTNmAnJTXPTD9vlBaS0bxUmlQwk017Dh/MhHkoxJgqll0y+hh8naEy2N4h4Cs/JMCa8AlC+5UPis1kY+EICM=
Received: by 10.65.159.3 with SMTP id l3mr1338403qbo.1183981240697;
        Mon, 09 Jul 2007 04:40:40 -0700 (PDT)
Received: by 10.65.185.15 with HTTP; Mon, 9 Jul 2007 04:40:40 -0700 (PDT)
Message-ID: <cda58cb80707090440u1d320fc0u1cc04f95a443e226@mail.gmail.com>
Date:	Mon, 9 Jul 2007 13:40:40 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [2.6 patch] include/asm-mips/processor.h: "extern inline" -> "static inline"
Cc:	"Adrian Bunk" <bunk@stusta.de>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20070709102754.GB24487@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070707010330.GY3492@stusta.de>
	 <20070709102754.GB24487@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 7/9/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Jul 07, 2007 at 03:03:30AM +0200, Adrian Bunk wrote:
>
> > "extern inline" will have different semantics with gcc 4.3,
> > and "static inline" is correct here.
>
> The idea was to have a linker error in case gcc should deciede for some
> reason not to inline this function which as I understand will continue
> to be the behaviour of gcc 4.3?
>

I don't know for this peculiar case but it usually is a good thing to
let gcc decide if the function needs to be inlined or not.

If we really want this function to be inlined in all cases, maybe we
should use __always_inline attribute instead ?

-- 
               Franck
