Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 07:31:15 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.224]:27840 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037622AbXBIHbI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 07:31:08 +0000
Received: by nz-out-0506.google.com with SMTP id x7so762196nzc
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2007 23:30:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rdG+37l/7OsM+Q1zmMbsEV4aD+CshVefmKhZ67cq8UIIuIkpsBCSeeYBpfk03Fm/s3bLSl/Up1xcpnQ9icMdEh4LIOmmfE8xmOFhN1sUtDTxtLAtDpkzQ7wh2tAtIx/3Xd0ceVJAOfiA3ZSfg/xVi0laaSdW9RkDYIkcBWll2Xs=
Received: by 10.114.211.1 with SMTP id j1mr4671871wag.1171006206771;
        Thu, 08 Feb 2007 23:30:06 -0800 (PST)
Received: by 10.114.168.17 with HTTP; Thu, 8 Feb 2007 23:30:06 -0800 (PST)
Message-ID: <50c9a2250702082330g3dd5497fq3d3f6be099845a0a@mail.gmail.com>
Date:	Fri, 9 Feb 2007 15:30:06 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: is there a patch to use mmc/sd through bio or make_request?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

       in our board, DMA can not handle sg, so i want to remove
blk_rq_map_sg, and just use the bio. is there any patch to do this?

      thanks for any hints

Best Regards

zhuzhenhua
