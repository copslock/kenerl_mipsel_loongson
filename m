Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 09:52:20 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.232]:35554 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021969AbXEGIwS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 09:52:18 +0100
Received: by wr-out-0506.google.com with SMTP id q50so1540760wrq
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 01:51:17 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sy1WoHd9aDWCLegy0Pqr3py11INU6Gyt9vFDNme8Mjvow2ULdrc0hoM/GFnNMUa6ugJTB8TWUnjv5dsGqPdHFd2/mhXORPkuGO0hNpf49aKwGngFRYWpLMudpDfdJThfXyscvgtRlCygFTf6YK7PQ97TClSteuLixL5ibVRZxNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eBAYlLdDiggmi1R1C5GrQPOXxF+OFQLJz82dwCJOrtXiYSIr14+3gqy02+dOL1TYb8EobF7d0PcPTJa8QZRF7Z8iBNVDlJj4mGTt8CFKrv96ZqurYBqUHQMu6sZmnyRlhIh2wE68Ay0Fp78nvwqMH1jxstXlOmwMqhy8Ho5JqK0=
Received: by 10.115.46.9 with SMTP id y9mr990947waj.1178527877426;
        Mon, 07 May 2007 01:51:17 -0700 (PDT)
Received: by 10.115.94.16 with HTTP; Mon, 7 May 2007 01:51:17 -0700 (PDT)
Message-ID: <cda58cb80705070151g75c1fcf3pa2b173d14475e4df@mail.gmail.com>
Date:	Mon, 7 May 2007 10:51:17 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070506.011636.92588372.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
	 <11782930063123-git-send-email-fbuihuu@gmail.com>
	 <20070506.011636.92588372.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/5/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> As I wrote in another mail I think we can not remove board_time_init
> for now, but if you really removed it please update
> Documentation/mips/time.README too.
>

Let see where this thread will lead us but in any cases I agree.

-- 
               Franck
