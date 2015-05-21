Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:18:28 +0200 (CEST)
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36514 "EHLO
        mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012557AbbEUWS00u8kT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:18:26 +0200
Received: by qcir1 with SMTP id r1so601775qci.3
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wxr2wCaxG1kXPVB5T8tg810uhythBfRuXf3+krTfWFA=;
        b=pq8OePE5t1tUJKFgthcxqsmI9c7zTCBenoEoeSUL3t4g6MB8eBbjJQSKy/I1SHmXo6
         n7B+LqDN1tJvmZxIQOnKGgFpqfiMAUXrlFxPm6wHAn1flGva2Z2k7zyYZtmCyWNtHzKE
         aiYMNGXgzgPJMiGgZrBhX4yUcbpUAkWjpXWoNsOHmGerLHfdggUplTZYLb9NXOLkk5P8
         WifXdC3BtwiaC7gMK6As2tGOHX9iI0iUu/JJVN6gA1JCnyNVgGxoH++v9iNTFlWng2f7
         cA8fQ3HZsSp7e9wBBlbkByK/OWLcBbdjZ5QQMKvYWOLgwWOIQIujWWXOaTGnn2nAKzgW
         gMNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wxr2wCaxG1kXPVB5T8tg810uhythBfRuXf3+krTfWFA=;
        b=Dl1jaEUMe37F6WNEstGfDfEayz4hmz5zpp1IJ0APMVtuJlUXfy06/sWErL34KqFsNX
         3fArviT9ZKnVuQhaueUjxfHLlCKAk+Gd3NQ01qeji8Iad2bW6c7xpi7GGUxtVlkZM/IS
         IE38KdVSLLwuu8p9AEhEs+hjcuBZbW9dsbvWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wxr2wCaxG1kXPVB5T8tg810uhythBfRuXf3+krTfWFA=;
        b=hGGssha3QrRSUF4eHI72Kp1CoAEU4tLrQLfNw10Xj74sdPZYgeBwdyn4QapKjpXVGQ
         SqxNxH3Wf+0Rf3iTdi1aJU9S6X4A7Z1BZ/D5dtYq9SHEUsnHQnDej2nOfLwVgMnErpEY
         wvjtznfgeaJAC1djCoxHkNz9bpQvQLB573vg9RBuyzaWysq92d33T6xx3EETPJ5ONq9o
         yvwpHhkl7POo8nmiUCsH0bSqSmIrmVDnZUsJsK4QJUc+UqVmNurZuTYg+0fFlvJtUYai
         ZVoUib8a1yyKE3EYXCFEDoKehP2R53pk5+GGldCqNHl2MBp+YKc4kA6i311jLVroLaRA
         I79Q==
X-Gm-Message-State: ALoCoQnrrUdHp0nk0bDc31HJFzguKfiSbLCJL15RHlG1/ZBV1AIAdjoEz8cS4FXSRZ3xuDWtywju
MIME-Version: 1.0
X-Received: by 10.140.91.42 with SMTP id y39mr6896438qgd.90.1432246703215;
 Thu, 21 May 2015 15:18:23 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Thu, 21 May 2015 15:18:23 -0700 (PDT)
In-Reply-To: <1432244260-14908-3-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244260-14908-3-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Thu, 21 May 2015 15:18:23 -0700
X-Google-Sender-Auth: Am6DawEQ_8CRNpakq3mZRcXa5Ng
Message-ID: <CAL1qeaHRrVCqQDVD9f0yG8M_+WZdLTL24Wf=PNQpZ7D=5dLpNQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clocksource: mips-gic: Add missing error returns checks
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Thu, May 21, 2015 at 2:37 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> This commit adds the required checks on the functions that return
> an error. Some of them are not critical, so only a warning is
> printed.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
