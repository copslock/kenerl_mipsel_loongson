Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:40:46 +0200 (CEST)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:38838 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493571AbZJUOkj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:40:39 +0200
Received: by yxe42 with SMTP id 42so325939yxe.22
        for <linux-mips@linux-mips.org>; Wed, 21 Oct 2009 07:40:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=twlaxPhnsUZlOKUe9bguPr9H4qJVcArLHpV7cG10Ysg=;
        b=mJaeWmnIctBfn4r5/MALzr8LjXP+WdburunWK/NKWqfq981aOZ7I5kHr0L41xang2m
         gwiJPkADo8zXLkEjhb9ztdaZw3/SG6yrrvp1FR6+q43S1rnX8bgUx882EBrfX2eUrX5R
         ZmF27U190dreFRrRVEZG6GwtC0dapRfbudlsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KgUFkh30Au0vifMHR3s1MevNyjKPy+v2MIP+PS8i1DLNT0H/pbFwWR+1MsqaR6CMFd
         x4VZXOuCEYDELTFjAJrUz9peC8zWjFVAfo7fW0VuRaO6vXI974/kdPVUOlHN+/39/DT/
         egrTtjGBJXj2DOp2UJ/drfo3rcqvBPAFy3PGk=
MIME-Version: 1.0
Received: by 10.90.121.17 with SMTP id t17mr8856459agc.57.1256136032931; Wed, 
	21 Oct 2009 07:40:32 -0700 (PDT)
Date:	Wed, 21 Oct 2009 22:40:32 +0800
Message-ID: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
Subject: Got trap No.23 when booting mips32 ?
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,


I've got some problem when booting mips32.


I got a No.23 trap when calling start_kernel --->  local_irq_enable :


irq 23, desc: 802a98a0, depth: 1, count: 0, unhandled: 0
->handle_irq():  80148c6c, handle_bad_irq+0x0/0x2b4
->chip(): 8029f738, 0x8029f738
->action(): 00000000
  IRQ_DISABLED set
unexpected IRQ # 23


No.23 trap is a Watch trap, which means that, when

"Physical address of load/store matched enabled value in


WatchLo/ WatahHi registers." happened, a No.23 trap was triggered by cpu.


So I used macro

__u32 watch_regh0= read_c0_watchhi0();
__u32 watch_regl0= read_c0_watchlo0();

to retrieve value from WatchHi and WatchLo,found them 0x1 and 0x0
respectively,which mean that ,

'r' together with  'w' bits were set to zero and no trap should be triggered.


But now , I got a 23 trap, why ?


At last , I used  to set WatchHi to 0x0, but failed , found it  still 0x1 after

calling write_c0_watchhi0(0)


Any suggestion would be grateful.

regards
