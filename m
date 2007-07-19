Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 12:36:47 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:3914 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022543AbXGSLgp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 12:36:45 +0100
Received: by py-out-1112.google.com with SMTP id p76so1013796pyb
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 04:36:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kdw5SZhbjOcMwSqM4ZzO8Sym1C5XUfvlKG9dS54rfit7PcPODtLewcGYyV9Bq8B5DMWtWkSPnb7oCMMkqZjzoP/76mMyKYMyPl39h+Z7Ec9YBqzFnJktS1Aegx6/nXpS6/MO/InzS43rQdTsyOPv1eZtV3fKFzqR93l1BR4qfxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MlEsElsDxw1bPUOlKlapodPGWoq7ngAv7t7TsDsP6t+yJ37vVrGYGY1C/VGJChnF3kTNWb1I4ieA628jT5zQIirEY8++BttpuNaZa7JIEAPUwAZuw91PuAubuZGBZMxC1JsY9ZPw86T8+CDaeP3V9z2Ns84uapv+/ivMUyzUp3o=
Received: by 10.65.119.14 with SMTP id w14mr4527775qbm.1184845003635;
        Thu, 19 Jul 2007 04:36:43 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 19 Jul 2007 04:36:43 -0700 (PDT)
Message-ID: <cda58cb80707190436p69c25087se1f8082b1b585a6f@mail.gmail.com>
Date:	Thu, 19 Jul 2007 13:36:43 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Nigel Stephens" <nigel@mips.com>
Subject: Re: [RFC] User stack pointer randomisation
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <469F3227.6090307@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <469F0E5F.4050005@innova-card.com> <469F3227.6090307@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 7/19/07, Nigel Stephens <nigel@mips.com> wrote:
>
> For the 64-bit ABIs (N32 & N64) the stack must be 16 byte aligned.
>

Thanks for this, I'll cook up a new patch.

-- 
               Franck
