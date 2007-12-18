Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 22:10:05 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.172]:5146 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28580325AbXLRWJ4 (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 18 Dec 2007 22:09:56 +0000
Received: by ug-out-1314.google.com with SMTP id k3so202142ugf.38
        for <linux-mips@ftp.linux-mips.org>; Tue, 18 Dec 2007 14:09:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JSpWUxCL5Ip8VogZEgs1d4hb2dNiymmevDkgDqIVeio=;
        b=pnlgLm9VCGJUnDUTPodmic0D9VVECQok/VMtzHzQdWiTOZ2Xj7g4P8GRdqTw2gYk4uuJ3rE/xFOyF/zb0uYTRFeA1nIzk9EEqK4okbNRWMjYgXMWjs4Un6jmJGmebWnQvQMHSVGovF5GJCvsFL/i3HdulANGpt9yR0UTiB+Acnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kYZd/ISYIHXtam1u+5m984P6DJNMdJauDMyOTxifeajVzbOeYeIivEnqccS590lo0Omyv+vLvjBl7KLWqsqa4L4RvMHlCRBuivjC85dY0z46ilau5721cRtlYK2kVzQ2pr4X1PIppO8Yoa6H8K0zlvXLxVa/8KfO8PHs6388Zo0=
Received: by 10.66.255.7 with SMTP id c7mr919600ugi.43.1198015786337;
        Tue, 18 Dec 2007 14:09:46 -0800 (PST)
Received: by 10.67.117.17 with HTTP; Tue, 18 Dec 2007 14:09:46 -0800 (PST)
Message-ID: <9e0cf0bf0712181409p2475e1fdk779fdee4fa274722@mail.gmail.com>
Date:	Wed, 19 Dec 2007 00:09:46 +0200
From:	"Alon Bar-Lev" <alon.barlev@gmail.com>
To:	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [MIPS] Build an embedded initramfs into mips kernel
Cc:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <47683B2D.9030608@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com>
	 <47683B2D.9030608@zytor.com>
Return-Path: <alon.barlev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alon.barlev@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/18/07, H. Peter Anvin <hpa@zytor.com> wrote:
> Make sure your /init doesn't depend on an interpreter or library which
> isn't available.

Thank you for your answer.

I already checked.

/init is hardlink to busybox, it depends on libc.so.0 which is available at /lib

But shouldn't I get a different error code if this is the case?

Best Regards,
Alon Bar-Lev.
