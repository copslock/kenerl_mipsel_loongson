Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 23:06:03 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:47771 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843085AbaDYVGApDDUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 23:06:00 +0200
Received: by mail-wi0-f177.google.com with SMTP id cc10so3262248wib.10
        for <linux-mips@linux-mips.org>; Fri, 25 Apr 2014 14:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=oNRhDxWQG+4lDq2ZyZzZazMmgO2/cBNwKCUisphu91s=;
        b=WvAQ2ub/QFaORFw3GEhP8c8Am8+pR4Tjc5rD1oAGkOxH61pI5TV/FcrWoQmalHBIuM
         jOs1hCfittUHHdLuSbKl5YAXL4xVXDE4CvWrgkaQAiXS5RnO+C81Q0Rwn7kLy5XzDsP4
         F3YD4hTxYM5MEdK8PKF63pASf1bHiN4/e7XmI+Kp2J6bIks9VHjN4w6blQeDlfe7yUwO
         yoXeUz86VEk8GjJ87N+JHg5a1XhIFkfJ5LbdLowwCZmW38DGKmeZJ4GF0CQpcSMZK7it
         UFlBYPbyDe6D++VlhVhPNaRnTDopcG6g241tZ6za+Fy8WPRlUmpxduEILiu0Inkey6aC
         QrWQ==
X-Gm-Message-State: ALoCoQkyqbKhwC6RHdhDbmqDYksBhk0HsJAgXcJYl7K/BllqqrwKvLlYbpYOkAv8b6r7lU5kgV7E
X-Received: by 10.194.171.167 with SMTP id av7mr8407081wjc.32.1398459954244;
        Fri, 25 Apr 2014 14:05:54 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id ez5sm12869678wjd.9.2014.04.25.14.05.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 14:05:53 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 11/21] MIPS: KVM: Rewrite count/compare timer emulation
Date:   Fri, 25 Apr 2014 22:05:42 +0100
Message-ID: <1591723.zAIKIVVUH7@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.11.5 (Linux/3.14.0+; KDE/4.11.5; x86_64; ; )
In-Reply-To: <535A94A5.1040200@gmail.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-12-git-send-email-james.hogan@imgtec.com> <535A94A5.1040200@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15069885.7FTzL28OdA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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


--nextPart15069885.7FTzL28OdA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

On Friday 25 April 2014 10:00:21 David Daney wrote:
> > +	/* Frequency of timer in Hz */
> > +	uint32_t count_hz;
> 
> We are currently running with timer frequencies of over 2GHz, so the
> width of this variable is close to the limit.

Interesting. Do you have 64-bit Count/Compare registers or just accept that 
you'll wrap after only 2 seconds? (it seems like a fairly short maximum idle 
time, though perhaps not important in the grand scheme of things)

> Your follow-on patch exports this to user-space as part of the KVM ABI.
> 
> I would suggest, at least for the user-space ABI, to make this a 64-bit
> wide value.

Yes, it's 64-bit wide in the userspace API, so it should be future proof. 
Currently it refuses to accept a value higher than 1GHz for numerical reasons 
though. If this same timer code is to be adapted for sleeping VZ guests too 
with those sorts of timer frequencies then it makes sense to ensure it can 
handle higher frequencies (since OTOH VZ doesn't give you control over the 
guest timer frequency, just the offset).

It's not strictly required for T&E though so I don't think it should be a 
blocking factor.

Thanks
James

--nextPart15069885.7FTzL28OdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTWs4vAAoJEGwLaZPeOHZ6PTIQAL3SA34V6s735NBH8mNCebcu
kr6KQ2H9BCwuv3v0trl8vTJfAOTDCJ+h0NoylI5/D5EEMKwxhMzEvreqxE94UTuP
wQtM3m3AMHDb7uOj5FvCzFBC5VvNQF7kM77WB0ZRlsWJXfsSRd1F6Ki9o1iK/kYm
OnnLrHvM01zflCMgEHu41omXAE9I+z73zE0jfJickpFMP4Kkdk+xWGBcMWDy3yjW
lePl/R687DoFdWKHO5nRSvs28ZuGOF5SNLVL99vQmOnL/6yHFVUVF/+c4jixVEy5
ACtYxP/5zTN274q+x4eDnWQKUudVUxMX8zaxQ0QrP69AJHr5a03GxZlEr0WMAqyN
q6/5WrtEP31aFptWaK2Ik2IKyJmZTDYKpS5X6mPSnfbbCJ+SbMwWNhKIGOsI2/L0
EINXYnj4yHKhC87FkAuO+TaojFLedq6V9xJO0nQkPCtnWhnEeYLTKLuyekHZ+O6C
cv9tYAKjzRdr9nVDxqCv3tQLxirSi1h44EoRrLJlpUDFL2XhbtT9FjSW1k+WfISR
RRh1s0+GvvX6uBJ08Qm1BslwGkE/BMSjxjR7VvSMuUsdc/Ktm6dHl/tOT7ysrhMj
3s9qJuic620ljZpOHwn+jeLM3BO/y1VmOwf/e2ysgPt0XxtaUEtCq721OVCJ99fP
yhbPxFI25NDcEM/3ynfx
=pnjw
-----END PGP SIGNATURE-----

--nextPart15069885.7FTzL28OdA--
