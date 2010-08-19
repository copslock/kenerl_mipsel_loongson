Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2010 17:34:31 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:34317 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab0HSPe1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Aug 2010 17:34:27 +0200
Received: by qyk35 with SMTP id 35so3459758qyk.15
        for <multiple recipients>; Thu, 19 Aug 2010 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=qRAgrTnodrP/YVWk+FP8mGHrHv4s1YXR1mwNYuYmvKA=;
        b=wRg0nAZDh9bo5/db2olcJBXqpfNWrDg+ggjiX+JfiYI9havaqf6xm4x58wUc8ZiDh3
         u6HZE0bAQ8gFEwdN0JypCVtViCV/1l2KpdGvm45PDXncTnFDpjRSbtwGaK0G1vEPbBVE
         QFuKiE7b0cxOemLTCbvQX4XUU2FIXQNGNB6ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Ft4UZo3bkk9XDzkU67ApA1YBeIgoC0SFLB0eq2rU7cdFIfoVCI89SQgvsQdggUN5mN
         053q/6HEkh8J4BokOzZmpycQ74ePX23wEESPQ/Upb/9KW4TKTCddfWXZwwsvcK3Z30PY
         xA8G6tkh16nSE7o80WPjq4NpdKvBlbe28s1oU=
MIME-Version: 1.0
Received: by 10.224.87.1 with SMTP id u1mr6591516qal.292.1282232061626; Thu,
 19 Aug 2010 08:34:21 -0700 (PDT)
Received: by 10.229.20.129 with HTTP; Thu, 19 Aug 2010 08:34:21 -0700 (PDT)
Date:   Thu, 19 Aug 2010 21:04:21 +0530
Message-ID: <AANLkTinURQyZgp7bzogjYGzLc5-CyDRGyGo9Hz=pUFFF@mail.gmail.com>
Subject: sparsemem support on MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        sshtylyov@mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

 Dear all,

I build MIPS 32 with sparsemem support to take care of holes in
physical memory, this conserve memory but put overhead to speed
because of pointer redirection in pfn_to_page().

To prevent this conversion I tried to use
CONFIG_SPARSEMEM_VMEMMAP_ENABLE on MIPS 32 but kernel build fails
becauase most of the supported functions related to vmemmap are
supported for 64 bit architectures only.

I wish to compare memory and speed result with / without
CONFIG_SPARSEMEM_VMEMMAP_ENABLE in MIPS 32. I need your comment in it
?

Thanks
