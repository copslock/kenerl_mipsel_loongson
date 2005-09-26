Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 08:07:12 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.200]:2705 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133507AbVIZHG5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Sep 2005 08:06:57 +0100
Received: by zproxy.gmail.com with SMTP id k1so40872nzf
        for <linux-mips@linux-mips.org>; Mon, 26 Sep 2005 00:06:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H8rY23czP+pkeQsM5XXrHSpnbGI/07Z5dRjlmSrTZvUl73yQPUpCgBv51z803SNI0jlZJPpHXJY/4mwXqnzPyXLyRkLj1bu06Sc42vlsDX5ABiAA3eYO53NxotUJWAyqHf6iKvYQ4NNynvTvXY206TVygX7sCRgND2bv2sUpkGc=
Received: by 10.36.101.9 with SMTP id y9mr1497813nzb;
        Mon, 26 Sep 2005 00:06:50 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Mon, 26 Sep 2005 00:06:50 -0700 (PDT)
Message-ID: <cda58cb8050926000665f843dc@mail.gmail.com>
Date:	Mon, 26 Sep 2005 09:06:50 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] minor fix in asm-mips/module.h
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch replaces an empty preprocessor condition #elif by #else. It
adds 4ksc and 4ksd as well.

Thanks.
--
               Franck
