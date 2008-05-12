Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 20:46:31 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.158]:55526 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20031765AbYELTq2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 20:46:28 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1488071ywk.24
        for <linux-mips@linux-mips.org>; Mon, 12 May 2008 12:46:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UQqDpcOtQFCNjVPtdc9rushsIIrOj6S3GYr7hzVzK3w=;
        b=Vc3C9NQdLg7WeAVngrmPcHPz5kD2OwlmewWtcdUxLRsDpmaP5Qw6RyKEK3KdIG9rYtRhWVf6e09mme60hrQrcMdb0RmMmVCFNjWrR73/VltLEDFkM9Pj+wC70Nb0cEZwXpUhnP1AFWxesSbtDOa7ZucPfwFok/9vmeCA5D/iLhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q9NL9JCYbNkFsJNaCAT9nxEb1NshVMPUpAW3zO9lIzQEPzyLgWzk9qH8PdKV3tndEXUDi79QCYUSG/d6X/rnWcVLMzXzP48RpeQPl4996PN/WYwIeYV+E9PRjaJgJXafaMDmB6x65zPbw371tp2l2LfSEyQ6gwmixgups8sJbAg=
Received: by 10.150.57.4 with SMTP id f4mr8734733yba.71.1210621579653;
        Mon, 12 May 2008 12:46:19 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Mon, 12 May 2008 12:46:19 -0700 (PDT)
Message-ID: <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
Date:	Mon, 12 May 2008 23:46:19 +0400
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: Malta build errors with 2.6.26-rc1
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080512163107.GA19052@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512163107.GA19052@deprecation.cyrius.com>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/5/12 Martin Michlmayr <tbm@cyrius.com>:
> Some Malta build errors:
>
>  cc1: warnings being treated as errors
>  arch/mips/mips-boards/malta/malta_int.c: In function 'gcmp_probe':
>  arch/mips/mips-boards/malta/malta_int.c:408: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/malta/malta_int.c: In function 'arch_init_irq':
>  arch/mips/mips-boards/malta/malta_int.c:437: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/malta/malta_int.c:441: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/malta/malta_int.c: In function 'malta_be_handler':
>  arch/mips/mips-boards/malta/malta_int.c:656: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/malta/malta_int.c:657: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/malta/malta_int.c:658: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/malta/malta_int.c:704: warning: cast to pointer from integer of different size
>  make[5]: *** [arch/mips/mips-boards/malta/malta_int.o] Error 1
>
>  and:
>
>  arch/mips/mips-boards/generic/amon.c: In function 'amon_cpu_avail':
>  arch/mips/mips-boards/generic/amon.c:31: error: implicit declaration of function 'KSEG0ADDR'
>  cc1: warnings being treated as errors
>  arch/mips/mips-boards/generic/amon.c:31: warning: cast to pointer from integer of different size
>  arch/mips/mips-boards/generic/amon.c: In function 'amon_cpu_start':
>  arch/mips/mips-boards/generic/amon.c:56: warning: cast to pointer from integer of different size
>  make[4]: *** [arch/mips/mips-boards/malta] Error 2
>

Known error. Please see this thread for some suggestions (and be
warned that I did not try any of them):

http://marc.info/?t=120966332300004&r=1&w=2

Dmitri
