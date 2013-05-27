Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 12:58:26 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43757 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823668Ab3E0K6YvQgnc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 12:58:24 +0200
Received: by mail-pa0-f45.google.com with SMTP id tj12so1775827pac.4
        for <multiple recipients>; Mon, 27 May 2013 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=rjhWR1BWl+xERD0kcSLQ6tETrH0FWxSqukQZNVZlDq0=;
        b=I104BYjoVnk2QHyT1CsgsKpNY9gAwCWgmNWA0e2scSWzZ7LrVO+j+dsNyEWD72k9uz
         j4lJrlil82cjLHAw5CbVhTdmp2i/bCduDcpCvaOAXBFXPmjIFyGvXMlXXvmxnXH5OTWA
         SYZQslAn3Frt5aADgoLJZXS2lf7FKYOX7SbvaUz94UFiW0JjkLPjE/0Gi4ZLdXhybLKX
         Daow+KcEI81vd+h+CBzy3AZrGrWrPpt5ZdvPe1CTHXrGtMSeoTIQ+3rXcKi1ysywFQ22
         iUC1arXhHzBqUTIpFmfjj9Ayj+bsIjwYkA5FxXHl74rFgFVXW07hKYOZKlJgKpW59lyF
         zMtQ==
X-Received: by 10.68.132.199 with SMTP id ow7mr28466839pbb.161.1369652298108;
        Mon, 27 May 2013 03:58:18 -0700 (PDT)
Received: from hades (111-243-158-188.dynamic.hinet.net. [111.243.158.188])
        by mx.google.com with ESMTPSA id vm10sm30217427pab.5.2013.05.27.03.58.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 03:58:17 -0700 (PDT)
Date:   Mon, 27 May 2013 18:58:10 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Steven.Hill@imgtec.com, macro@linux-mips.org,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v3 0/3] MIPS: microMIPS: Refactor get_frame_info support
Message-ID: <20130527105810.GA31548@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This is the microMIPS get_frame_info patch version 3. I 
splited previous patch into three to address issues pointed
out by Maciej and David.

Tony Wu (3):
  MIPS: microMIPS: Fix POOL16C minor opcode enum
  MIPS: microMIPS: Add kernel_uses_mmips in cpu-features.h
  MIPS: microMIPS: Refactor get_frame_info support

arch/mips/include/asm/cpu-features.h |    7 +
arch/mips/include/uapi/asm/inst.h    |    9 +-
arch/mips/kernel/process.c           |  341 +++++++++++++++++++++-------------
 3 files changed, 223 insertions(+), 134 deletions(-)

Tony
