Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 05:56:58 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.200]:64780 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133698AbWAIF4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 05:56:38 +0000
Received: by wproxy.gmail.com with SMTP id 36so3227774wra
        for <linux-mips@linux-mips.org>; Sun, 08 Jan 2006 21:59:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ggurlyqscqXQNsCt0Cn2BH6NDH4/sX92fNmjp1pbOt3OSdpirlIKNgNtLTu/T6GKkoBu+vPC/uxd2l1hzIuTUvU04SIeB3yCw+2Jmxjf2bn4R6BR+1oHlMsLkfulDRpFf8yoBjw3bU10x/D3lpaxZZUxRM9Oxsvj7UbCWQf8GDU=
Received: by 10.54.136.13 with SMTP id j13mr4808306wrd;
        Sun, 08 Jan 2006 21:59:35 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Sun, 8 Jan 2006 21:59:34 -0800 (PST)
Message-ID: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
Date:	Mon, 9 Jan 2006 13:59:34 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: why the early_initcall(au1x00_setup) do not work?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i download a standard 2.6.14 kernel, and compile it for dbau1100, and
i find the early_initcall(au1x00_setup) was not compiled into the
vmlinux.
and i find at the linux-mips cvs, it used plat_setup instead of early_initcall.
does it means my toolchain is not correct to compile the
early_initcall, or in the standard 2.6.14 kernel, the early_initcall
do not work well?

Best regards!

zhuzhenhua
