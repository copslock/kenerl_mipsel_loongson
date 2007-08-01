Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 14:18:20 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.185]:53585 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021813AbXHANSS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 14:18:18 +0100
Received: by fk-out-0910.google.com with SMTP id f40so177685fka
        for <linux-mips@linux-mips.org>; Wed, 01 Aug 2007 06:18:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m7CBtT8kFGWqITHI+bIl2iHodSNw11OuffZwqDT52gK16cQPoMwOTc91vzNcHN9n/lKKUa+SZEHskZ6jfDIKY7OYblca/j/asG+R72ZS3LggpFohK1zH0ZAzzdMEf74/xqj48Qdg1sLiWZFu/uhBTh5I5id7A+ObMt/5bFWmojo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eJQdT5tQX7iT+NNj0fU8nc+hfF7mhBOkQGYJKHSdJ/0Xu/PtLiSpCqxjsOC7haeGajAoC9gzwOn/aWiCGP2HoGGiIQw9NSnMJIfa5GZ6wWEiCIKTR2kmizQ9HuZQcU3DXCk1sjhz8gvQIZzocxTemDR/jtaJwvVtz5xfjO2x4/Y=
Received: by 10.82.182.1 with SMTP id e1mr741944buf.1185974280091;
        Wed, 01 Aug 2007 06:18:00 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Wed, 1 Aug 2007 06:18:00 -0700 (PDT)
Message-ID: <40378e40708010618r7a93e58br206e7c47e685a05e@mail.gmail.com>
Date:	Wed, 1 Aug 2007 15:18:00 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org
Subject: cacheops.h & r4kcache.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi *,
In those two header files, flush & invalidate operations were
implemented. Nevertheless, the MIPS32 core supports cache locking as
well. Is there any implementations for Fetch&Lock instructions within
the kernel?

Best regards,

-- 
Mohamed A. Bamakhrama
Web: http://home.cs.tum.edu/~bamakhra/
