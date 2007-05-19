Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 20:07:06 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:39012 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20024043AbXESTHE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 20:07:04 +0100
Received: by ug-out-1314.google.com with SMTP id 40so620206uga
        for <linux-mips@linux-mips.org>; Sat, 19 May 2007 12:06:03 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EnMTN3/3KTVjB2fzxX4ar/YnpWplEB7iJBU50YZmUQFlAxbWRmyjmbYQPTvUVgkQFBB0MeuCrx0M2563IiE6StFrB5SOuhLfLu07lWoRK7CCINIEXMY6zIAmp45WIDb5muGqDbLK1SjGdg8WKROd2BCqEF4KurN8KpyR1vyYmP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dxMHdvzs/pGLkvx64qahQ830kRFq84u8dkSGmMvbEBlxQthVNgD/wn3fwID9aMTUQGEN/M5+exDRR76rE6EJ3nRfzJ1yuiczrlqT4CMO9H6YVyTg9o2d4h2eaE+7b+MO6OKApkP8UMt6goRuSvJ6qRkC42/bpFvCNVRsxtYQxqg=
Received: by 10.82.145.7 with SMTP id s7mr5511787bud.1179601563290;
        Sat, 19 May 2007 12:06:03 -0700 (PDT)
Received: from ?85.101.65.168? ( [85.101.65.168])
        by mx.google.com with ESMTP id y37sm4230776iky.2007.05.19.12.06.00;
        Sat, 19 May 2007 12:06:01 -0700 (PDT)
From:	borasah@gmail.com
To:	linux-mips@linux-mips.org; linux-mtd@lists.infradead.org
Subject: Au1200 and NAND Flash - K9F1G08U0A -
Date:	Sat, 19 May 2007 22:13:11 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705192213.12019.borasah@gmail.com>
Return-Path: <borasah@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borasah@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

We want to use NAND flash on Alchemy Au1200 and have a custom board along with 
Db1200; so tried it both on our custom board and Db1200 without success.
(Because Db1200 has a slot we opened it and replaced the original with our 
part)

Kernel -> 2.6.20.1. Error messages:

NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V 
8-bit)
Scanning device for bad blocks
Bad eraseblock 0 at 0x00000000
Bad eraseblock 1 at 0x00020000
...
Bad eraseblock 1022 at 0x07fc0000
Bad eraseblock 1023 at 0x07fe0000
Creating 2 MTD partitions on "NAND 128MiB 3,3V 8-bit":

It marks all the eraseblocks as BAD. As far as I understand 
"au1xxx_nand_command" seems doesnt work correctly. Has someone succeded to 
work with these large block parts in the Au1200/Au1550?

Thanks...

--
Bora SAHIN
