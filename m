Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 07:39:02 +0100 (CET)
Received: from mail-iw0-f183.google.com ([209.85.223.183]:47455 "EHLO
        mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491852Ab0BAGi7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 07:38:59 +0100
Received: by iwn13 with SMTP id 13so254491iwn.20
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 22:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=oI84IL5wgTWFsyM2LwmGGXgIuAwXEjhhHfys4o7Rpgg=;
        b=b2bFuQ5CtuLDhFjIIYsbBUP2qK3gHM6+cXljLR+ZaITfHLbGhZrpYuUk8X7oUgWu1D
         D2guBhegOEtNSZqYG03RrgqlGlVCRlrzLy0rcdw+5nB/g/c5YHl1zhP7zDzEL7sCAuZD
         ihlm3WbIJPu1N2GQssESOaKi7pThuB1B0SgkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=O/lmP11HCdlMbN0MwJzuQYrulfdIRqH5Tk9g4wsHk/ExpsR4jzia4gn1xd3mIy2QJD
         2wxOKcF6rjlmFovYiO4J6hx5YM28aLTzlDoxDhyq3Mhc221EF7zpf85VbnStbDZmYZGy
         szI+ieeVArg73cIDYCKhI0ISAr2wbecTQrccA=
Received: by 10.231.85.198 with SMTP id p6mr3503398ibl.65.1265006333178;
        Sun, 31 Jan 2010 22:38:53 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm3140910iwn.9.2010.01.31.22.38.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 22:38:52 -0800 (PST)
Subject: Re: [PATCH 3/3] MIPS: AR7 make ar7_register_devices much more
 durable
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <dt2h37-ch6.ln1@chipmunk.wormnet.eu>
References: <dt2h37-ch6.ln1@chipmunk.wormnet.eu>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 01 Feb 2010 14:32:51 +0800
Message-ID: <1265005971.31984.10.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2010-01-31 at 19:39 +0000, Alexander Clouter wrote:
> MIPS: AR7 make ar7_register_devices much more durable
> 

All of the printk(KERN_XXX stuff can be replaced by pr_xxx defined in
include/linux/kernel.h

Regards,
	Wu Zhangjin
