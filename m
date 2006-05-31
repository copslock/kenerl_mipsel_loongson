Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 02:33:48 +0200 (CEST)
Received: from nf-out-0910.google.com ([64.233.182.188]:55348 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133454AbWEaAdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 02:33:39 +0200
Received: by nf-out-0910.google.com with SMTP id p46so58975nfa
        for <linux-mips@linux-mips.org>; Tue, 30 May 2006 17:33:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c3/3n8rtgSLX8ItJaSVqm5BroJqSn7FIjs4ZPJ3Ewjmv1oCu/xuUYL6hIeaK9vDJsb6KpQ67BYyOr4V4I57oh2Nmbbat851Ef3qxEnOs0dX++E4IIaPZ3yAe5kTi+rVL6NyUWHGvsykmVET+hSXuLcMHFicq4eGYoClD6ejy22M=
Received: by 10.48.210.7 with SMTP id i7mr216176nfg;
        Tue, 30 May 2006 17:33:38 -0700 (PDT)
Received: by 10.66.241.4 with HTTP; Tue, 30 May 2006 17:33:38 -0700 (PDT)
Message-ID: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com>
Date:	Wed, 31 May 2006 08:33:38 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to disable interrupt in application?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

our project have a video decoder code run as application. there is
some short code want to be run uninterruptable. is there anyway to do
it?
thanks for any hints
Best Regards


zhuzhenhua
