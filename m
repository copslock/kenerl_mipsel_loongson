Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 17:11:05 +0100 (CET)
Received: from mail-qg0-f42.google.com ([209.85.192.42]:51157 "EHLO
        mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008109AbaLLQLDvJd94 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 17:11:03 +0100
Received: by mail-qg0-f42.google.com with SMTP id q108so3640297qgd.29
        for <multiple recipients>; Fri, 12 Dec 2014 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xx5TucM77VtZPdgzODZthaqgjcusjdccMgBlmJz1UCc=;
        b=p2lSBiRIkARVz75TbZl9qetAhunrybeYfLbG8LaZaAVVIfgswgaFNDW5IHTNPw+myY
         6gX9JUOH5tQh0kIJHyBm39nr5vmbbR+yq9glBr+n7n3yNuMcnRlNvoXhd4yGj5yjagIP
         lM0GA0cKffX0/72OzsW0R7bXCVvowgD8HbFNtpiiBc0xMyudOteX5OQz22p99iVqfWQC
         1q+wKnstPm7wjEEzLIOtRjjlN6fy+XsacIIRKbbcbwtQEGLrQSgKMHHzrPcqJk6mqtnZ
         KZzkbyBfE02aZt2Fi6Qc5th/wJWJxRrVjvZjemHRsSnBpDEoHP0sqsSS4Ezn+bVj21GX
         IIYQ==
X-Received: by 10.140.34.67 with SMTP id k61mr30424132qgk.95.1418400658041;
 Fri, 12 Dec 2014 08:10:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Fri, 12 Dec 2014 08:10:37 -0800 (PST)
In-Reply-To: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
References: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 12 Dec 2014 08:10:37 -0800
Message-ID: <CAJiQ=7ALgSfawoTOKH-1iqm90q1sgukqZZwxjFjMAzX5Z6hbVQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: use phys_addr_t instead of phy_t
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Fri, Dec 12, 2014 at 7:26 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> add missing patch of commit "MIPS: Replace use of phys_t with phys_addr_t".
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Thanks, this fixes a compile error seen on Linus' head of tree.

Acked-by: Kevin Cernekee <cernekee@gmail.com>
