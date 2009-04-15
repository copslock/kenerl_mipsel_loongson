Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 02:23:13 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.186]:58751 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022388AbZDOBXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Apr 2009 02:23:05 +0100
Received: by ti-out-0910.google.com with SMTP id 11so326461tim.20
        for <multiple recipients>; Tue, 14 Apr 2009 18:23:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=nX4Fc18cZvu55VFWJxshqKBpjkAVStAtTYOqxACICDI=;
        b=geI3jOz5OfGlIs4IyC37sBJvf1KBodsl2Whc5MwKsgXLZBoF+pU3xyh4dL2G5DhHnE
         1sN/HkOxX/Zn9sfmF/RokXqbGCdQ49KcRsqaPAOnUs7Zl0TkulDzMhMF6bzJxUHkRLgX
         mjmCO9LKxvaqx4RGSHhYxAfUaUUQp36zxTOzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KmZT2KoWxXppvQ0u0H3TEqcq1J0CkLgEW0wr9CTXi93fkF2PK6YYwquiJkVoL+DvC9
         JriG6LRAGbITEtnJdlldVemlokJxdK06nMAdcm78do/61C6hkrwirek04uy92MsQgxbv
         aJ67d4IbW8C9u6xBO0wZvaWecOiFQrNN9TPCU=
Received: by 10.110.28.15 with SMTP id b15mr9123119tib.9.1239758581516;
        Tue, 14 Apr 2009 18:23:01 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id j5sm88406tid.37.2009.04.14.18.22.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Apr 2009 18:22:59 -0700 (PDT)
Subject: Re: [PATCH] ftrace porting of linux-2.6.29 for mips
From:	falcon <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20090414124001.GB28950@adriano.hkcable.com.hk>
References: <b00321320904021847w5ab3acb6nd1cd554c251ef8f6@mail.gmail.com>
	 <20090403113315.GC6629@adriano.hkcable.com.hk>
	 <b00321320904030503w8fe0165t2aded6727f35e24c@mail.gmail.com>
	 <b00321320904030551p774d295lce3581c23d9d8c26@mail.gmail.com>
	 <20090403141158.GA27751@adriano.hkcable.com.hk>
	 <b00321320904030753s2e10503fud4ba50b0fda13d8f@mail.gmail.com>
	 <20090403160304.GB27751@adriano.hkcable.com.hk>
	 <20090403180652.GC27751@adriano.hkcable.com.hk>
	 <20090414124001.GB28950@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 15 Apr 2009 09:22:42 +0800
Message-Id: <1239758562.3538.57.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-04-14 at 20:40 +0800, Zhang Le wrote:
> I got ftrace working on fuloong 2f box, finally.
> 
> The patch could be get here:
> http://repo.or.cz/w/linux-2.6/linux-loongson.git?a=shortlog;h=refs/heads/linux-2.6.29-stable-ftrace-from-wu
> 
> It is the second last patch in the above git repo.
> 
> Also I have attached a working config for fuloong 2f box and a test script.
> 
> Zhang, Le

thanks very much!

I have read your test script, which seems only test the static function
tracer, not include the "dynamic function tracer" and "function graph
tracer". since both of them are ported to mips.

currently, "dynamic function tracer" works well, but "function graph
tracer" maybe crash for some NMI exceptions, need to be fixed later.

Wu Zhangjin
