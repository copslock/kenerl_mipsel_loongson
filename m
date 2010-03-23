Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2010 02:45:53 +0100 (CET)
Received: from mail-qy0-f199.google.com ([209.85.221.199]:46540 "EHLO
        mail-qy0-f199.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492643Ab0CWBpr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Mar 2010 02:45:47 +0100
Received: by qyk37 with SMTP id 37so1106251qyk.8
        for <linux-mips@linux-mips.org>; Mon, 22 Mar 2010 18:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YI+utzdxbl0AFcDdmySPYirZbxKgUaVs7TAa2rea77Y=;
        b=QNehrRxGTzKogmRUtdCDgNxYfGpbYN3IpZxkG1taXoT3L6TtrqkInBDxGVItoBWOO2
         mhHHQlTAz8bRybKedJxlFmbPOvKw+/xKePvCZvC+hQyDV6YQxArNgbeiZ6L2qr7zRK4F
         PLV6sMJktUVgUXb2yd+NyJ+yed/mmzlTSV558=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4df7sDQngGQWZWTxO2+tc3z9xybERuRqHjmHEYMf7YZFAu5s81QvW/COIl7SjxU5p
         d3ZFNM1+7jWjiEG/zS/N6OjwcpTBByRM3PwTD/vtQdIrufYUm7TJZwRHzZUHu8Ol3bqq
         opCp399DJIe8ljXX+IJ4Rd2vuRZupH6Pd8feY=
MIME-Version: 1.0
Received: by 10.229.212.4 with SMTP id gq4mr669473qcb.62.1269308740967; Mon, 
        22 Mar 2010 18:45:40 -0700 (PDT)
In-Reply-To: <4BA81BC7.5060600@caviumnetworks.com>
References: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
         <4BA79E69.1040803@caviumnetworks.com>
         <e732b6801003221830y2c2ca423tb67d74f7a3639c22@mail.gmail.com>
         <4BA81BC7.5060600@caviumnetworks.com>
Date:   Tue, 23 Mar 2010 09:45:40 +0800
Message-ID: <e732b6801003221845i4f86ff8ftea56d656bfd20f10@mail.gmail.com>
Subject: Re: [BUG?] cavium cn56xx and dma_map_single warning
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mlistz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 23, 2010 at 9:39 AM, David Daney <ddaney@caviumnetworks.com> wrote:

> The issue is maintaining mappings for 32-bit PCI devices.  If you only want
> to support 64-bit devices, it would be easier to address the issue.
>
> David Daney
>

Wow, that is a great news, I do not known if my adaptec 3045e raid
card is a 64bit device, but if I only want to support 64bit devices,
Is there a quick fix for it?

Zhuang Yuyao
