Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 12:00:02 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.190]:60051 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023848AbXHCK77 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 11:59:59 +0100
Received: by fk-out-0910.google.com with SMTP id f40so695061fka
        for <linux-mips@linux-mips.org>; Fri, 03 Aug 2007 03:59:42 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XuutVhNkTQyJgRpMrbZcyvZ20fyF81hzjyY6wHTi2d9UNXNddchZQkDJ5KZIU8fMBi20Dsh6vOVvHu4TGkTjJCNU83C/icxQGS1a5PgcZ55UXWKzevy9o0yr0cCeh3zKdq+1CrJPxcJ8wmpCmW0t0AMVAzktZZV5S/+tiEV35XY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dagjaHSBluzrBwqL42r68B+YwkhCJUNuA3RCotO1HE7eCv1AA+fwn8SqEWz0Ja1zK5MJ0TNq8ASd5gl9Xj1I77frrcSimL1JVvUUyuPx6mdni/eekOlcMeDoL+2jUwyen+1A6T3RFrobJr4WnLmvMo1J+/RCSRQdJwmtz+bWXsQ=
Received: by 10.82.170.2 with SMTP id s2mr3688209bue.1186138781942;
        Fri, 03 Aug 2007 03:59:41 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Fri, 3 Aug 2007 03:59:41 -0700 (PDT)
Message-ID: <40378e40708030359h3729e4b1m5390c258b29d6ae0@mail.gmail.com>
Date:	Fri, 3 Aug 2007 12:59:41 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org
Subject: Context switches & interrupts affecting cache?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,
I have one question regarding context switches between user and kernel
modes and interrupts. Do they invalidate the I-cache or D-cache?

Best regards,

-- 
Mohamed
