Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 16:32:22 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.190]:3217 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024430AbXHGPcU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 16:32:20 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1772337fka
        for <linux-mips@linux-mips.org>; Tue, 07 Aug 2007 08:32:01 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JqRKBx6M1aupLdmAtrZzKsZnqh0tdajeeqHPhWE5PsRX7iZycWK5Gr7mXSCcOTvAmvkDs4BVCkXtEocpQqHCQnFX2EulyOyAHuunJsXodhUOhE73a66XldmweMtHLw7Ygpe35cncLEYJbtZ7yNbS2UqnSiz/JryfCOZytEKNPXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sUaAokzBW8B6JinRLsyJQX1biPBA6oHaHMe/4wel+owffwhPQkcRe7zJ4DsKjK4Rd7YerokNuJssB3wTyTuQC/mHF7WhcoBsQWkdcw2/uO5VLEeYxehU55BCh7sA4Yhouwfmh35RVwx3cr8fQS8HZuWstrTLmSnpZcAfkVFCGjI=
Received: by 10.82.162.14 with SMTP id k14mr6819475bue.1186500720472;
        Tue, 07 Aug 2007 08:32:00 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Tue, 7 Aug 2007 08:32:00 -0700 (PDT)
Message-ID: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
Date:	Tue, 7 Aug 2007 17:32:00 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org
Subject: ELF to S-Record convertor
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi *,
Does anyone know of any open source tool for converting ELF images to
S-Record images?
I am using Malta board with MIPS32 core.

Regards,

-- 
Mohamed A. Bamakhrama
Am Schaeferanger 15, room 035
85764 Oberschleissheim, Germany
Email: bamakhra@cs.tum.edu
Web: http://home.cs.tum.edu/~bamakhra/
Mobile: +49-160-9349-2711
