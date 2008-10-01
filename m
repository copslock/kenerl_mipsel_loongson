Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2008 19:31:02 +0100 (BST)
Received: from ik-out-1112.google.com ([66.249.90.182]:5465 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20284711AbYJASbA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Oct 2008 19:31:00 +0100
Received: by ik-out-1112.google.com with SMTP id c30so654831ika.0
        for <linux-mips@linux-mips.org>; Wed, 01 Oct 2008 11:30:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:organization:to
         :subject:date:user-agent:x-face:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zThGdXRlHndV1qOCktoG/1q18Bk7AmMDVHVewpWKVNk=;
        b=D/JM0Bs7MPRmIm7TEvLYqpFD2aqZFgMI4Vfj7yKqoj4IxR/WA5tPz8d9fuLGLeXOT1
         Jm8wufRw0oYC4W8T7d0aA1UXgvb4m91SWAMqlKqGMAu18tRUnr0HIacKeRNSP0nQTXqE
         NnERFp4ApspgI7r3cuvVjEP7Uws08ha5EsmaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:organization:to:subject:date:user-agent:x-face
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ddl9O213KSuemODZo/s1z099oEWvpoNZvW/397rg7BqLHkYKY+7CMr7bRU9KUvc/MU
         kfgv9cjIQVaK6Gr6PaAEINpcq3cs5SqkwQoVUUz+RRpiApOFJ3o9r+06JlfQDLCUzno8
         OHQZ6Iz5JjUBRR4SXJrylnFY/JZMBxZ66stC4=
Received: by 10.86.92.7 with SMTP id p7mr7645163fgb.8.1222885859365;
        Wed, 01 Oct 2008 11:30:59 -0700 (PDT)
Received: from cartesio.localnet ( [85.46.108.250])
        by mx.google.com with ESMTPS id l19sm6677564fgb.7.2008.10.01.11.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 11:30:58 -0700 (PDT)
From:	"Luigi 'Comio' Mantellini" <luigi.mantellini.ml@gmail.com>
Reply-To: luigi.mantellini.ml@gmail.com
Organization: Industrie Dial Face S.p.A.
To:	linux-mips@linux-mips.org
Subject: Huge buffer allocation: best place
Date:	Wed, 1 Oct 2008 20:30:53 +0200
User-Agent: KMail/1.10.1 (Linux/2.6.24-21-generic; KDE/4.1.1; i686; ; )
X-Face:	'6!%DGk.Oa/l`>tHr&^29|<`2s/|PIbM@0,\4g%@-F7xr9V,K@Iu<A>G-jQ\T_t@ZM5UC7
	.l0\.nz[=$C9^`vJt;P=ZRBk2+x+pB)\8;"bA3>@5aI66l5Xfw*X8#+kcy1ybOBUNMnc;s
	UXb\&]+8*bloRi<euepX(,esSS\}3j|oU|_Xku72+-?C0miI}a^~$j-O-/ELA-gTX/IVUi
	%fmY6(!tfc}&,mzme<IwkA;^CKV:vIY</xKrN8F6`X~EPI#-B4*e"I;edO
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_eH84Ihmvxn+0UD7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810012030.54480.luigi.mantellini.ml@gmail.com>
Return-Path: <luigi.mantellini.ml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luigi.mantellini.ml@gmail.com
Precedence: bulk
X-list: linux-mips

--Boundary-00=_eH84Ihmvxn+0UD7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi ml,

I need to allocate a huge contiguous buffer (~6MByte) shared with a secondary 
cpu (a packet processor). Which is the best place and the best way to do this?

The main problem is that using a simple kmalloc at module init time there 
isn't sufficient contiguous memory to cover the request. I should use (I 
suppose) the alloc_bootmem_* macros but I'm not sure where is the best place 
to reserve my memory.

For now I defined a global bad huge vector... but I'm not happy for this 
solution...

thanks in advance.

luigi

-- 
Luigi Mantellini
R&D - Software
Industrie Dial Face S.p.A.
Via Canzo, 4
20068 Peschiera Borromeo (MI), Italy
Tel.:  +39 02 5167 2813
Fax:   +39 02 5167 2459
Email: luigi.mantellini@idf-hit.com


--Boundary-00=_eH84Ihmvxn+0UD7
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'DejaVu Sans'; font-size:10pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hi ml,</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I need to allocate a huge contiguous buffer (~6MByte) shared with a secondary cpu (a packet processor). Which is the best place and the best way to do this?</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The main problem is that using a simple kmalloc at module init time there isn't sufficient contiguous memory to cover the request. I should use (I suppose) the alloc_bootmem_* macros but I'm not sure where is the best place to reserve my memory.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">For now I defined a global bad huge vector... but I'm not happy for this solution...</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">thanks in advance.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">luigi</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-- </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Luigi Mantellini</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">R&amp;D - Software</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Industrie Dial Face S.p.A.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Via Canzo, 4</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">20068 Peschiera Borromeo (MI), Italy</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Tel.:  +39 02 5167 2813</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Fax:   +39 02 5167 2459</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Email: luigi.mantellini@idf-hit.com</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p></body></html>
--Boundary-00=_eH84Ihmvxn+0UD7--
