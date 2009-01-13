Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 15:07:57 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.244]:59334 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S21103613AbZAMPHz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 15:07:55 +0000
Received: by an-out-0708.google.com with SMTP id d14so17801and.24
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 07:07:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=zynWAcqnwVH9cJGXKfyE0gvkC/tlUSvpVzZve4F+jQs=;
        b=YNA3BeKXGrVBr7yxKZVKCdiF0Uidq0hMFn1vnpIVGW2TkKSVCaIIw6LPrSCkS5BkyD
         nZ9X+SFwX/RU4DNg0KFfsEHWmqz8W9H2drquSQndatuvNBnl2ZBM7W8lLOWb4fwE4LWX
         bP3UHDok0TmLfgzax+rFmqU0Zx816irvwylrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=dLeBVCefUPYSi83nO8OYd1g3L8vB6ZAoceA0icRDbcfzHSv5Q+0wkB2uLr8lgahZk/
         rv30Gk/YTMwoD3OF94Px3DtyDurwRvWfhe9HPzdJP/pXofU/vaAua3x7y2jiMG6om0h2
         Hq22sFWZhUyNxtDNqbBsV7RuE7iSpI48glZlo=
Received: by 10.100.178.9 with SMTP id a9mr16477181anf.59.1231859273628;
        Tue, 13 Jan 2009 07:07:53 -0800 (PST)
Received: from ?10.6.11.31? (cpmsq.epam.com [217.21.56.2])
        by mx.google.com with ESMTPS id c1sm7833715ana.19.2009.01.13.07.07.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 07:07:52 -0800 (PST)
Subject: [pnx833x_port]: device name prefix - ttyS or ttySA?
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 13 Jan 2009 17:07:50 +0200
Message-Id: <1231859270.25974.32.camel@EPBYMINW0568>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.2 
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

In 'drivers/serial/pnx833x_port.c' we define the prefix for UART serial
device as "ttyS". Anyway, we use major:minor numbers for SA1100 serial
driver (that are 204:5). Why don't we use "ttySA" prefix then? That's
what different embedded build systems expect for populating /dev (f.e.
buildroot).
