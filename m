Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 05:49:14 +0200 (CEST)
Received: from mail-px0-f180.google.com ([209.85.216.180]:41891 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491870AbZICDtG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2009 05:49:06 +0200
Received: by pxi10 with SMTP id 10so1259434pxi.24
        for <linux-mips@linux-mips.org>; Wed, 02 Sep 2009 20:48:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=dDJFC9y6nTBskvboK2b2JNiC2P1h49rjgto6tohHado=;
        b=A36yBJBshKqqQl+Q9zS9ZKzAmVFULn0nm6ewfYgZDiPvfV4DcTko0vmYqqTrxR5HSZ
         7b1VlJ6n0LSa3L4lqnWGSzwRcilRjQ5nNrjD7e3jEZjcOyXcrUPYFau4JuerHP0smILj
         u4gA7KUeMikO84bobqqXyKo+QCFdT4b6T8MII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cdSLC+MfnOb3pBBoDmDS3RTy3JKIhy+dQgz8D0Go4DT7w9Xt1VmT1hXSeMeGDqqo4J
         ck9P/2nlqwPl4+Vorr9iTLoKbvzRhOTHYNNZDd/cCwyXyaNqA0CJeJqfRwSkuiERUPTZ
         +EMMFATTeItTMa2kwy/XS4j35iIvEXYstV2h4=
MIME-Version: 1.0
Received: by 10.142.75.16 with SMTP id x16mr204125wfa.155.1251949739619; Wed, 
	02 Sep 2009 20:48:59 -0700 (PDT)
Date:	Thu, 3 Sep 2009 11:48:59 +0800
Message-ID: <91b13c310909022048q467dff7cl90284b57132f4f14@mail.gmail.com>
Subject: How to debug glibc-2.10.1 mips on linux multilib o32 ld or libc 
	Segmentation fault?
From:	Cheng Renquan <crquan@gmail.com>
To:	libc-help@sourceware.org, linux-mips@linux-mips.org,
	issues@eglibc.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <crquan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crquan@gmail.com
Precedence: bulk
X-list: linux-mips

Hello, all,
  Recently I have cross compiled GCC-4.4.1 with eglibc-2.10.1,
with a multilib configuration, o32/n32/n64, the result is that n32/n64
can work well, while o32 libs always Segmentation fault,

I have read this but still have no good idea on how to debug,

http://sources.redhat.com/glibc/wiki/Debugging/Development_Debugging

then I run it like this,

$ LD_DEBUG=all eglibc-install-root-o32/lib/ld.so.1 --library-path
$PWD/eglibc-install-root-o32/lib
eglibc-install-root-o32/usr/bin/locale

it ends with:

     30257:	symbol=__stack_chk_guard;  lookup in
file=eglibc-install-root-o32/usr/bin/locale [0]
     30257:	symbol=__stack_chk_guard;  lookup in
file=/mnt/nas/yutech/homes/user/eglibc-install-root-o32/lib/libc.so.6
[0]
     30257:	symbol=__stack_chk_guard;  lookup in
file=eglibc-install-root-o32/lib/ld.so.1 [0]
     30257:	binding file eglibc-install-root-o32/lib/ld.so.1 [0] to
eglibc-install-root-o32/lib/ld.so.1 [0]: normal symbol
`__stack_chk_guard' [GLIBC_2.4]
     30257:	
     30257:	calling init:
/mnt/nas/yutech/homes/user/eglibc-install-root-o32/lib/libc.so.6
     30257:	
Segmentation fault

So please give some inputs on how to resolve this? Thanks,

-- 
Cheng Renquan
