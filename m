Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2007 04:46:42 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:58853 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022252AbXH0Dqe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Aug 2007 04:46:34 +0100
Received: by nf-out-0910.google.com with SMTP id c10so946635nfd
        for <linux-mips@linux-mips.org>; Sun, 26 Aug 2007 20:46:16 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nd6wD46V+OjBC6kFQnCC2BoaFSJ2erAdtBTvkxRfmK6zi5QAUg5govSHKZN/bGpgh4QlNK119r/TCWDI1NEMMZ7i/R7WdxdKKs2pXx3kR8RMZuJqWa7M35i5EHCuCUwNttNaJkq1c6rOrpPICokjWg+wkPUxIpTNiAPz6A9wJC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QITw+XhqIcs4kFd+aJL0c4/p+XJB5EMfh3BOlo+fMHTbHGlhRBzQrDtTdj3U7hcKt5uSuSCs7oFYjWvwmWmyUEzQdl7Z1/xg1p9tLIS8wMEYtoeXtO6LMUGTCyRYRVCWkKIaKwJlAB9tW7KLzgaqyeXhEDxsMVRHr875IRD4g1o=
Received: by 10.78.172.20 with SMTP id u20mr3511656hue.1188186376318;
        Sun, 26 Aug 2007 20:46:16 -0700 (PDT)
Received: by 10.78.151.16 with HTTP; Sun, 26 Aug 2007 20:46:16 -0700 (PDT)
Message-ID: <e81c31b60708262046q6e2f0abl1a31c42378913083@mail.gmail.com>
Date:	Sun, 26 Aug 2007 20:46:16 -0700
From:	"James Hartley" <jjhartley@gmail.com>
To:	linux-mips@linux-mips.org
Subject: enabling second IDE channel on Cobalt RaQ 2?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <jjhartley@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jjhartley@gmail.com
Precedence: bulk
X-list: linux-mips

The following page:

http://www.linux-mips.org/wiki/Cobalt

...mentions that with a minimum of changes, the second IDE channel can
be enabled on a Cobalt RaQ2, yet what resistors, transistors, etc.,
are not specified nor in what configuration.  Performing a Google
search keeps coming back to this page.  Does anyone have information
on what needs to be done in order to enable the second IDE channel?

Thanks for any candor shared.

Jim
